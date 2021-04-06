//
//  PostsController.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 23.03.2021.
//

import UIKit
import RealmSwift


class PostsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var token = Session.userInfo.token
    var userId = Session.userInfo.userId
    var version = "5.130"
    private let networkPosts = NetworkPosts()
    var groupsArr: [Group] = []
    var itemsArr: [Items] = []
    var dispatchGroup = DispatchGroup()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        dispatchGroup.enter()
        networkPosts.getDataForPost(
            handlerGroup: { [weak self] groups in
                self?.groupsArr = groups
            },
            handlerItems: { [weak self] items in
                self?.itemsArr = items
                self!.dispatchGroup.leave()
            })
        
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewsCell
        let idItems = itemsArr[indexPath.row].itemId
        
        //        for group in groupsArr {
        //            if idItems == -group.id {
        let name = groupsArr[indexPath.row].name
        let photo = groupsArr[indexPath.row].photo_50
        let text = itemsArr[indexPath.row].text
        let comment = itemsArr[indexPath.row].comments
        let likes = itemsArr[indexPath.row].likes
        let reposts = itemsArr[indexPath.row].reposts
        let date = itemsArr[indexPath.row].date
        let views = itemsArr[indexPath.row].views
        cell.setDataPost(name: name, photo: photo, text: text, commentCount: comment, likes: likes, reposts: reposts, date: date, views: views)
        //            }
        //        }
        return cell
    }
}
