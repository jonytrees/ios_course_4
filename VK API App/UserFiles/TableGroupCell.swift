//
//  TableGroupCellTableViewCell.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 12.02.2021.
//

import UIKit

class TableGroupCell: UITableViewCell {

   
    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var name: String = ""
    
    func setName(name: String) {
        nameLabel.text = name
    }
    
    func setNamePhoto(name: String, photo: String) {
        let urlImg = URL(string: photo)
        let dataImg = try? Data(contentsOf: urlImg!)
        imageGroup.image = UIImage(data: dataImg!)
        
        nameLabel.text = name
    }
    
}
