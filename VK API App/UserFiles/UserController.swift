//
//  User.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 11.02.2021.
//

import UIKit
import RealmSwift

class UserController: UIViewController {
    var token = Session.userInfo.token
    var userId = Session.userInfo.userId
    var version = "5.130"
    var userData: [UserStruct] = []
    var jsonData: [UserStruct] = []
    var userObject: [UserObject] = []
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var birthdayUser: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    private var tokenRealm: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        tokenRealm = Databases().getRawDataUser()?.observe({(changes) in
            switch changes {
            case .initial(let initial):
                UIView.animate(withDuration: 0.6, delay: 0.0, options: [.autoreverse]) {
                    self.view.backgroundColor = .red
                } completion: {(_) in
                
                }
                print(initial)
                break
            case .update(let res, deletions: [], insertions: [], modifications: []):
                let data = Array(res)
                self.userObject = data
                break
            case .error(let error):
                print(error)
                break
            default:
                break
            }
        })
    }
    
    private func addUserDatabase() {
        let db = Databases()
        userData.forEach({db.write($0.toUserObject())})
    }
    
    func getData() {
        
        if let url = URL(string: "https://api.vk.com/method/users.get?user_ids=\(userId)&fields=bdate&access_token=\(token)&v=5.130") {
            let session = URLSession.shared
           
            
            let task = session.dataTask(with: url) { [self] (data, response, error) in
                do{
                    let json = try? (JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as? [String: Any]
                    let jsondata = try? JSONSerialization.data(withJSONObject: json!["response"]!)
                    let jsonDecoder = try JSONDecoder().decode([UserStruct].self, from: jsondata!)
                    self.userData = jsonDecoder
                    self.addUserDatabase()
                
                    
                    let chArray = Databases().read()
                    chArray?.forEach({self.userData.append($0.toUserStruct())})
                    for user in self.userData {
                        DispatchQueue.main.async {
                            self.userName.text = String(user.first_name) + " " + String(user.last_name)
                            self.birthdayUser.text = String(user.bdate)
                            self.userIdLabel.text = String(user.id)
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
}




