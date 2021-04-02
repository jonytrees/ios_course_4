//
//  FirebaseController.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 02.03.2021.
//

import UIKit

class FirebaseController: UIViewController {
    
    var token = Session.userInfo.token
    var userId = Session.userInfo.userId
    var version = "5.130"
    var userData: [UserStruct] = []
    var userGroup: [GroupStruct] = []
    var userIdNumber: String = ""
    var name: String = ""
    var arrNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        getUserId()
        getGroupUser()
    }
    

    func getUserId() {
        if let url = URL(string: "https://api.vk.com/method/users.get?user_ids=\(userId)&fields=bdate&access_token=\(token)&v=5.130") {
            let session = URLSession.shared
           
            let task = session.dataTask(with: url) { [self] (data, response, error) in
                do{
                    let json = try? (JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as? [String: Any]
                    let jsondata = try? JSONSerialization.data(withJSONObject: json!["response"]!)
                    let jsonDecoder = try JSONDecoder().decode([UserStruct].self, from: jsondata!)
                    self.userData = jsonDecoder
                    
                    for user in self.userData {
                        DispatchQueue.main.async {
                            self.userIdNumber = String(user.id)
                            self.name = user.first_name + " " + user.last_name
                        }
                    }
                }
                catch{
                    print(error)
                }
            }
            task.resume()
        }
    }
    
    
    func getGroupUser() {
        if let url = URL(string: "https://api.vk.com/method/groups.get?extended=1&fields=bdate&access_token=\(token)&v=\(version)") {
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                let json = try? ((JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String: AnyObject])
                let main_first = json!["response"]
                let items =  main_first!["items"]
    
                do{
                    let itemsData = try JSONSerialization.data(withJSONObject: items!!)
                    
                    self.userGroup = try JSONDecoder().decode([GroupStruct].self, from: itemsData)

                    DispatchQueue.main.async {
                        for names in self.userGroup {
                            self.arrNames.append(names.name)
                        }
                        FirebaseService.shared.pullIdAndGroups(nameUser: self.name, id: self.userIdNumber, name: self.arrNames)
                    }
                }
                catch{
                    print(error)
                }
            }
            task.resume()
        }
    }

}
