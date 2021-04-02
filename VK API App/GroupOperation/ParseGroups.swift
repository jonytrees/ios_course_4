//
//  ParseGroups.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 29.03.2021.
//

import Foundation
import RealmSwift

class ParseGroups: Operation {
    var groupsData: [Group] = []
    var arrGroups: [String] = []

    
    override func main() {
        guard let getOperationData = dependencies.first as? GetDataOperation else { return }
        guard let data = getOperationData.data else { return }

        let json = try? ((JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as! [String: AnyObject])
        let main = json!["response"]
        let items = main!["items"]
        
        let groups = try? JSONSerialization.data(withJSONObject: items!!)
            
        let dataAll = try! JSONDecoder().decode([Group].self, from: groups!)
        
       
        groupsData = dataAll
       
        
        let db = Databases()
        groupsData.forEach({db.writeGroupOperation($0.toGroupObject())})
    }
}
