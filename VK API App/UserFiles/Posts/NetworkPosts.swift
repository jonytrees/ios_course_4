//
//  NetworkPosts.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 24.03.2021.
//

import Foundation

class NewsItemsParser {
    private var groups: [Group] = []
    private var items: [Items] = []
    private var syncQueue = DispatchQueue(label: "NewsItemsParserQueue", attributes: .concurrent, target: DispatchQueue.global(qos: .background))
    
    init(items:[Items], groups: [Group]) {
        self.items = items
        self.groups = groups
    }
    
    func getItems() -> [Items] {
        var localItems: [Items] = []
        syncQueue.sync {
            localItems = items
        }
        return localItems
    }
    
    func getGroups() -> [Group] {
        var localGroups: [Group] = []
        syncQueue.sync {
            localGroups = groups
        }
        return localGroups
    }
    
    func mergeItem(at index: Int) {
        syncQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let item = self.items[index]
             let isGroup = item.itemId < 0
             if isGroup {
                let group = self.groups.first(where: {$0.id == -item.itemId})
                self.items[index].authorName = group?.name ?? ""
                self.items[index].ava = group?.photo_50 ?? ""
             }
        }
    }
}

class NetworkPosts {
    
    var token = Session.userInfo.token
    var userId = Session.userInfo.userId
    var version = "5.130"
    var groups: [Group] = []
    var items: [Items] = []

    
    func getDataForPost(handlerGroup: @escaping ([Group]) -> Void, handlerItems: @escaping ([Items]) -> Void) {
        
        let urlString = "https://api.vk.com/method/newsfeed.get?count=20&filters=post&source_ids=groups&access_token=\(token)&v=\(version)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data != nil && error == nil {
                let apiResponse = try? JSONDecoder().decode(Response.self, from: data!)
                let items = apiResponse!.response.items
                let groups = apiResponse!.response.groups
                let dispatchGroup = DispatchGroup()
                
//                for item in items!.enumerated() {
//                    DispatchQueue.global().async(group: dispatchGroup) {
//                        let itemsId = item.element.itemId
//                        let group = apiResponse?.groups.first(where: {$0.id == -itemsId})
//                        items![item.offset].authorName = group?.name ?? ""
//                    }
//                }
                let itemsParser = NewsItemsParser(items: items, groups: groups)
                
               
                    for i in 0..<items.count {
                        DispatchQueue.global().async(group: dispatchGroup) {
                            itemsParser.mergeItem(at: i)
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    handlerGroup(itemsParser.getGroups())
                    handlerItems(itemsParser.getItems())
                }
            } else {
                print("network error")
            }
        }.resume() 
    }
}
