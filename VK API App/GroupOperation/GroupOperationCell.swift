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
    func setNamePhoto(name: String, photo: String) {
        let urlImg = URL(string: photo)
        let dataImg = try? Data(contentsOf: urlImg!)
        imageGroup.image = UIImage(data: dataImg!)
        
        nameLabel.text = name
        nameLabel.numberOfLines = 1
    }

}
