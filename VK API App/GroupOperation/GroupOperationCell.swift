//
//  GroupOperationCell.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 29.03.2021.
//

import UIKit

class GroupOperationCell: UITableViewCell {
    
    
    @IBOutlet weak var imageGroup: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    func setNamePhoto(name: String, photo: UIImage?) {
        
        imageGroup.image = photo
        
        nameLabel.text = name
        nameLabel.numberOfLines = 1
    }

}
