//
//  OtherTableView.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 15.02.2021.
//

import UIKit
import RealmSwift

class GroupController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var token = Session.userInfo.token
    var userId = Session.userInfo.userId
    var version = "5.52"
    var result: [GroupStruct] = []
    var resultRealm: [GroupStruct] = []
    var groupDates: [GroupStruct] = []
    var groupObject: [GroupObject] = []

    private var tokenRealm: NotificationToken?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if let url = URL(string: "https://api.vk.com/method/groups.get?extended=1&fields=bdate&access_token=\(token)&v=\(version)") {
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                let json = try? ((JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String: AnyObject])
                let main_first = json!["response"]
                let items =  main_first!["items"]

                do{
                    
                    let itemsData = try JSONSerialization.data(withJSONObject: items!!)
                    
                    self.result = try JSONDecoder().decode([GroupStruct].self, from: itemsData)

                    let groupArray = Databases().readGroup()
                    groupArray?.forEach({self.result.append($0.toGroupStruct())})
                    DispatchQueue.main.async {
                        self.addGroupDatabase()
                        self.tableView.reloadData()
                    }
                }
                catch{
                    print(error)
                }
            }
            task.resume()
        }
        
        tokenRealm = Databases().getRawDataGroup()?.observe({(changes) in
            switch changes {
            case .initial(let initial):
                UIView.animate(withDuration: 0.6, delay: 0.0, options: [.autoreverse]) {
                    self.view.backgroundColor = .black
                } completion: {(_) in
                
                }
                print(initial)
                break
            case .update(let res, deletions: [], insertions: [], modifications: []):
                let data = Array(res)
                self.groupObject = data
                break
            case .error(let error):
                print(error)
                break
            default:
                break
            }
        })
        
        
    }
    
    func addGroupDatabase() {
//        let db = Databases()
//        resultRealm.forEach({db.writeGroup($0.toGroupObject())})
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableGroupCell
        let name = result[indexPath.row].name
        cell.setName(name: name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
