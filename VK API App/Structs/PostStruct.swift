//
//  PostStruct.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 23.03.2021.
//

import Foundation
import RealmSwift

struct Response: Decodable {
    var response: Container
}

struct Container: Decodable {
    var groups: [Group]
    var items: [Items]
}


//class Group: Object, Decodable {
//    @objc dynamic var name: String = ""
//    @objc dynamic var photo_50: String = ""
//
//    override init() {}
//
//    convenience required init(name: String, photo_50: String) {
//        self.init()
//        self.name = name
//        self.photo_50 = photo_50
//    }
//
//    func toGroupStruct() -> GroupStruct {
//        return GroupStruct(name: name, photo_50: photo_50)
//    }
//}

struct Group: Decodable {
    var id: Int = 0
    var name: String = ""
    var photo_50: String = ""
}

struct CommentsContainer: Decodable {
    var count: Int = 0
}

struct Items: Decodable {
    var itemId: Int = 0
    var text: String = ""
    var date: Int = 0
    var comments: Int = 0
    var likes: Int = 0
    var reposts: Int = 0
    var views: Int = 0
    var authorName: String = ""
    var ava: String = ""


    enum CodingKeys: String, CodingKey {
        case itemId = "source_id"
        case text
        case date
        case comments
        case likes
        case reposts
        case views
        case count
    }

    enum CommentsKeys: String, CodingKey {
        case count
    }
    
    init(from decoder: Decoder) throws {
        let items = try decoder.container(keyedBy: CodingKeys.self)
        self.itemId = try items.decode(Int.self, forKey: .itemId)
        self.text = try items.decode(String.self, forKey: .text)
        self.date = try items.decode(Int.self, forKey: .date)

        let commetsJson = try items.nestedContainer(keyedBy: CodingKeys.self, forKey: .comments)
        self.comments = try commetsJson.decode(Int.self, forKey: .count)

        let likesJson = try items.nestedContainer(keyedBy: CodingKeys.self, forKey: .likes)
        self.likes = try likesJson.decode(Int.self, forKey: .count)

        let repostsJson = try items.nestedContainer(keyedBy: CodingKeys.self, forKey: .reposts)
        self.reposts = try repostsJson.decode(Int.self, forKey: .count)

        let viewsJson = try items.nestedContainer(keyedBy: CodingKeys.self, forKey: .views)
        self.views = try viewsJson.decode(Int.self, forKey: .count)
    }
}

