//
//  NetworkPosts.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 24.03.2021.
//

import Foundation

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
                let apiResponse = try? JSONDecoder().decode(Response.self, from: data!).response
                if apiResponse != nil {
                    handlerGroup(apiResponse!.groups)
                    handlerItems(apiResponse!.items)
                } else {
                    print("json parse error")
                }
            } else {
                print("network error")
            }
        }.resume() 
    }
}
