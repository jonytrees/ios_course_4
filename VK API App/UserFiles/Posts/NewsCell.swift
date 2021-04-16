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
        let dateFormat = NewsCellDateFormatter.shared.string(from: date)
        dateLabel.text = String(dateFormat)
        nameNew.lineBreakMode = .byCharWrapping
        nameNew.numberOfLines = 0
        nameNew.text = name
        let dataImg = NewsCellDateFormatter.shared.image(from: photo)
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


private class NewsCellDateFormatter {
    static let shared = NewsCellDateFormatter()
    private var cache = [TimeInterval: String]()
    let format: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    func string(from timeInterval: Int) -> String {
        let timeInterval = TimeInterval(timeInterval)
        if let result = cache[timeInterval] {
            return result
        } else {
            let myNSDate = Date(timeIntervalSince1970: timeInterval)
            let formattedDate = format.string(from: myNSDate)
            cache[timeInterval] = formattedDate
            return formattedDate
        }
    }
    
    func image(from url: String) -> Data? {
        let urlImg = URL(string: url)
        let dataImg = try? Data(contentsOf: urlImg!)
        return dataImg
    }
}
