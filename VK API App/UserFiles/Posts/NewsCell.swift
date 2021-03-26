//
//  NewsCellTableViewCell.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 21.03.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var nameNew: UILabel!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var textPost: UITextView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var repostsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    func setDataPost(name: String, photo: String, text: String, commentCount: Int, likes: Int, reposts: Int, date: Int, views: Int) {
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let timeInterval = TimeInterval(date)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        let formattedDate = format.string(from: myNSDate)
        dateLabel.text = String(formattedDate)
        
        nameNew.lineBreakMode = .byCharWrapping
        nameNew.numberOfLines = 0
        nameNew.text = name

        let urlImg = URL(string: photo)
        let dataImg = try? Data(contentsOf: urlImg!)
        imagePost.image = UIImage(data: dataImg!)
        
        textPost.text = text
        textPost.translatesAutoresizingMaskIntoConstraints = false
        textPost.sizeToFit()
        textPost.isScrollEnabled = true
        commentLabel.text = String(commentCount)
        likeLabel.text = String(likes)
        repostsLabel.text = String(reposts)
        viewsLabel.text = String(views)
    }

}
