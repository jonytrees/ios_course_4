//
//  PromisesViewCell.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 06.04.2021.
//

import UIKit

class PromisesViewCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var imageFriends: UIImageView!
    func setNameFriends(firstName: String, lastName: String, photo: String) {
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        
        let urlImg = URL(string: photo)
        let dataImg = try? Data(contentsOf: urlImg!)
        imageFriends.image = UIImage(data: dataImg!)
    }

}
