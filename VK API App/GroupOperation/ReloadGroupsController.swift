//
//  ReloadGroupsController.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 29.03.2021.
//

import Foundation


class ReloadGroupsController: Operation {
    var controller: GroupOperationController
    
    init(controller: GroupOperationController) {
        self.controller = controller
    }
    
    override func main() {
        guard let parseDataGroup = dependencies.first as? ParseGroups else { return }
        
        controller.groupsData = parseDataGroup.groupsData
        controller.tableView.reloadData()
    }
}
