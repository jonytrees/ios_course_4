//
//  GetDatesController.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 01.02.2021.
//

import UIKit

class GetDatesController: UIViewController {
    var token = Session.userInfo.token
    var userId = Session.userInfo.userId
    var version = "5.52"
    
    let configuration = URLSessionConfiguration.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Databases()
    }

    @IBAction func friendsButton(_ sender: Any) {
        let session = URLSession(configuration: configuration)
        let url = URL(string: "https://api.vk.com/method/friends.get?user_ids=\(userId)&fields=bdate&access_token=\(token)&v=\(version)")
        let task = session.dataTask(with: url!) { (data, response, error) in
            do{
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                
                if let main_first = json!["response"] {
                    let count = main_first["count"]
                    print("Количество ваших друзей: \(count! ?? 0)")
                }
                print(json!)
            }
        }
        task.resume()
    }
    
    @IBAction func photosButton(_ sender: Any) {
        let session = URLSession(configuration: configuration)
        let url = URL(string: "https://api.vk.com/method/photos.getAll?user_ids=\(userId)&fields=bdate&access_token=\(token)&v=\(version)")
        let task = session.dataTask(with: url!) { (data, response, error) in
            do{
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                
                if let main_first = json!["response"] {
                    let count = main_first["count"]
                    print("Количество ваших фотографий: \(count! ?? 0)")
                }
                
                print(json!["response"]!["items"]!!)
            }
        }
        task.resume()
    }
    
    @IBAction func groupsButton(_ sender: Any) {
        let session = URLSession(configuration: configuration)
        let url = URL(string: "https://api.vk.com/method/groups.get?user_ids=\(userId)&fields=bdate&access_token=\(token)&v=\(version)")
        let task = session.dataTask(with: url!) { (data, response, error) in
            do{
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                
                if let main_first = json!["response"] {
                    let count = main_first["count"]
                    print("Количество ваших сообществ: \(count! ?? 0)")
                }
                
                print(json!)
            }
        }
        task.resume()
    }
    
}
