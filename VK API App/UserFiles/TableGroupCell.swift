//
//  TableGroupCellTableViewCell.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 12.02.2021.
//

import UIKit

class TableGroupCell: UITableViewCell {

   
    @IBOutlet weak var nameLabel: UILabel!
    var name: String = ""
    
    func setName(name: String) {
        nameLabel.text = name
    }
    
}
