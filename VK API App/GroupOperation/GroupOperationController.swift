//
//  GroupOperationController.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 29.03.2021.
//

import UIKit

struct GroupsStruct {
    var name: String
    var photo: String
}

class GroupOperationController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var token = Session.userInfo.token
    var userId = Session.userInfo.userId
    var version = "5.130"
    var groupsData: [Group] = []
    let operationQueue = OperationQueue()
    var photoService: PhotoService?
    
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let urlString = "https://api.vk.com/method/groups.get?extended=1&fields=bdate&access_token=\(token)&v=\(version)"
        
        let url = URLRequest(url: URL(string: urlString)!)
        
        let getDataOperation = GetDataOperation(request: url)
        operationQueue.addOperation(getDataOperation)
        
        let parseData = ParseGroups()
        parseData.addDependency(getDataOperation)
        operationQueue.addOperation(parseData)
        
        
        let reloadController = ReloadGroupsController(controller: self)
        reloadController.addDependency(parseData)
        OperationQueue.main.addOperation(reloadController)
        
        photoService = PhotoService(container: tableView)
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GroupOperationCell
        let name = groupsData[indexPath.row].name
        let photo = photoService?.photo(atIndexpath: indexPath, byUrl: groupsData[indexPath.row].photo_50)
        cell.setNamePhoto(name: name, photo: photo)
        return cell
    }
}
