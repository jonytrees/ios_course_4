//
//  PromisesViewController.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 06.04.2021.
//

import UIKit
import PromiseKit
import Alamofire

struct ItemsFriends: Decodable {
    var firstName: String = ""
    var lastName: String = ""
    var photo: String = ""
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
    }
    
    init(from decoder: Decoder) throws {
        let items = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try items.decode(String.self, forKey: .firstName)
        self.lastName = try items.decode(String.self, forKey: .lastName)
        self.photo = try items.decode(String.self, forKey: .photo)
    }
}

class PromisesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var token = Session.userInfo.token
    var userId = Session.userInfo.userId
    var version = "5.130"
    var friendsArr: [ItemsFriends] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        forecast().done(on: .main) { [weak self] friends in
            self?.friendsArr = friends
            self!.tableView.reloadData()
        }
    }
    
    func forecast() ->
    Promise<[ItemsFriends]> {
        let arr: [ItemsFriends] = []
        guard let url = URL(string: "https://api.vk.com/method/friends.get?user_ids=\(userId)&fields=bdate&access_token=\(token)&v=\(version)") else {
            return Promise.value(arr)
        }
        
        return URLSession.shared.dataTask(.promise, with: url)
            .then(on: DispatchQueue.global()) { response -> Promise<[ItemsFriends]> in
                let dataFriends = response.data
                let json = try? ((JSONSerialization.jsonObject(with: dataFriends, options: .mutableContainers)) as! [String: AnyObject])
                let main = json!["response"]
                let items = main!["items"]
                
                let friends = try? JSONSerialization.data(withJSONObject: items!!)
                let data = try? JSONDecoder().decode([ItemsFriends].self, from: friends!)
                
                return Promise.value(data ?? [])
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPromises") as! PromisesViewCell
        
        let firstName = friendsArr[indexPath.row].firstName
        let lastName = friendsArr[indexPath.row].lastName
        let photoFriends = friendsArr[indexPath.row].photo
        
        cell.setNameFriends(firstName: firstName, lastName: lastName, photo: photoFriends)
        
        return cell
    }
    
}
