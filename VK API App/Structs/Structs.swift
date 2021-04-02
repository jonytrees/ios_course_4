//
//  Structs.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 22.02.2021.
//

import Foundation
import RealmSwift


struct FairbaseNameGroup {
    var nameUser: String = ""
    var id: String = ""
    var name: [String] = []

    func toDictGroup() -> [String: Any] {
        return ["name user": nameUser, "id": id, "name group": name]
    }
}


struct UserStruct: Codable {
    var id: Int
    var first_name: String
    var last_name: String
    var bdate: String
    
    func toUserObject() -> UserObject {
        return UserObject(id: id,
                          first_name: first_name,
                          last_name: last_name,
                          bdate: bdate)
    }
}

struct GroupStruct: Decodable {
    var name: String
    var photo_50: String
    
    func toGroupObject() -> Group {
        return Group(name: name, photo_50: photo_50)
    }
    
}

struct PhotoStruct: Decodable {
    var photo_1280: String
    
    func toPhotoObject() -> PhotoObject {
        return PhotoObject(photo: photo_1280)
    }
}


struct NewsStruct: Decodable {
    var name: String
    var photo_100: String
    
    func toNewsObject() -> NewsObject {
        return NewsObject(name: name, photo: photo_100)
    }
}

struct TextNewsStruct: Decodable {
    var text: String?
//    var comments: CommentStruct?
    
    func toTextNewsObject() -> TextNewsObject {
        return TextNewsObject(text: text ?? "")
    }
}


//struct CommentStruct: Decodable {
//    var comments: Int?
//    var comments: CommentStruct?
//
//    func toCommentObject() -> CommentsObject {
//        return CommentsObject(comments: comments ?? 0)
//    }
//}




class UserObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var bdate: String = ""
    
    override init() {}
    
    convenience required init(id: Int, first_name: String, last_name: String, bdate: String) {
        self.init()
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.bdate = bdate
    }
    
    func toUserStruct() -> UserStruct {
        return UserStruct(id: id,
                          first_name: first_name,
                          last_name: last_name,
                          bdate: bdate)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


class GroupObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var photo_50: String = ""
    
    override init() {}
    
    convenience required init(name: String, photo_50: String) {
        self.init()
        self.name = name
        self.photo_50 = photo_50
    }
    
    func toGroupStruct() -> GroupStruct {
        return GroupStruct(name: name, photo_50: photo_50)
    }
}


class PhotoObject: Object {
    @objc dynamic var photo_1280: String = ""
    
    override init() {}
    
    convenience required init(photo: String) {
        self.init()
        self.photo_1280 = photo
    }
    
    func toPhotoStruct() -> PhotoStruct {
        return PhotoStruct(photo_1280: photo_1280)
    }
}


class NewsObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var photo_100: String = ""
    
    override init() {}
    
    convenience required init(name: String, photo: String) {
        self.init()
        self.name = name
        self.photo_100 = photo
    }
    
    func toNewsStruct() -> NewsStruct {
        return NewsStruct(name: name, photo_100: photo_100)
    }
}

class TextNewsObject: Object {
    @objc dynamic var text: String? = ""
//    dynamic var comments: CommentStruct = CommentStruct(can_post: 0, count: 0)
    
    override init() {}
    
    convenience required init(text: String) {
        self.init()
        self.text = text
//        self.comments = comments
    }
    
    func toTextNewsStruct() -> TextNewsStruct {
        return TextNewsStruct(text: text ?? "")
    }
}


//class CommentsObject: Object {
//    @objc dynamic var comments: Int? = 0
//    dynamic var comments: CommentStruct = CommentStruct(can_post: 0, count: 0)
    
//    override init() {}
//
//    convenience required init(comments: Int) {
//        self.init()
//        self.comments = text
//        self.comments = comments
//    }
    
//    func toCommentsStruct() -> CommentsStruct {
//        return CommentsStruct(comments: comments ?? 0)
//    }
//}

