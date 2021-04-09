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
    
    func setNameFriends(firstName: String, lastName: String) {
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
    }

}
