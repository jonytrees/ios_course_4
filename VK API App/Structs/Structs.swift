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



// TODO: User
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


// TODO: Group
struct GroupStruct: Decodable {
    var name: String
    var photo_50: String
    
    func toGroupObject() -> GroupObject {
        return GroupObject(name: name, photo_50: photo_50)
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


// TODO: GroupOperation
class GroupOperationObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var photo_50: String = ""
    
    override init() {}
    
    convenience required init(name: String, photo_50: String) {
        self.init()
        self.name = name
        self.photo_50 = photo_50
    }
    
    func toGroupOperationStruct() -> Group {
        return Group(name: name, photo_50: photo_50)
    }
}


// TODO: Photo
struct PhotoStruct: Decodable {
    var photo_1280: String
    
    func toPhotoObject() -> PhotoObject {
        return PhotoObject(photo: photo_1280)
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

// TODO: News
struct NewsStruct: Decodable {
    var name: String
    var photo_100: String
    
    func toNewsObject() -> NewsObject {
        return NewsObject(name: name, photo: photo_100)
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


// TODO: TextNews
struct TextNewsStruct: Decodable {
    var text: String?
    
    func toTextNewsObject() -> TextNewsObject {
        return TextNewsObject(text: text ?? "")
    }
}

class TextNewsObject: Object {
    @objc dynamic var text: String? = ""
    
    override init() {}
    
    convenience required init(text: String) {
        self.init()
        self.text = text
    }
    
    func toTextNewsStruct() -> TextNewsStruct {
        return TextNewsStruct(text: text ?? "")
    }
}

