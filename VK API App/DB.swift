//
//  DB.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 17.02.2021.
//

import Foundation
import RealmSwift

class Databases {
    
    private var db: Realm?
    
    
    
    init() {
        db = try? Realm()
        print("file database: \(String(describing: db?.configuration.fileURL))")
    }
    
    func write(_ object: UserObject) {
        do {
            db?.beginWrite()
            db?.add(object, update: .all)
            try db?.commitWrite()
        }
        catch{
            print("something error user")
        }
    }
    
    
    func writePhoto(_ object: PhotoObject) {
        do {
            db?.beginWrite()
            db?.add(object)
            try db?.commitWrite()
        }
        catch{
            print("something error photo")
        }
    }
    
    func writeGroup(_ object: GroupObject) {
        do {
            db?.beginWrite()
            db?.add(object)
            try db?.commitWrite()
        }
        catch{
            print("something error group")
        }
    }
    
    func writeGroupOperation(_ object: GroupOperationObject) {
        do {
            db?.beginWrite()
            db?.add(object)
            try db?.commitWrite()
        }
        catch{
            print("something error group")
        }
    }
    
    func writeNews(_ object: NewsObject) {
        do {
            db?.beginWrite()
            db?.add(object)
            try db?.commitWrite()
        }
        catch{
            print("something error news")
        }
    }
    
    func writeTextNews(_ object: TextNewsObject) {
        do {
            db?.beginWrite()
            db?.add(object)
            try db?.commitWrite()
        }
        catch{
            print("something error text")
        }
    }
    
    
    func read() -> [UserObject]? {
        if let objects = db?.objects(UserObject.self) {
            
            return Array(objects)
        }
        return nil
    }
    
    func getRawDataUser() -> Results<UserObject>? {
        if let objects = db?.objects(UserObject.self) {
            return objects
        }
        return nil
    }
    
    func readPhoto() -> [PhotoObject]? {
        if let objects = db?.objects(PhotoObject.self) {
            
            return Array(objects)
        }
        return nil
    }
    
    func getRawDataPhoto() -> Results<PhotoObject>? {
        if let objects = db?.objects(PhotoObject.self) {
            return objects
        }
        return nil
    }
    
    func readGroup() -> [GroupObject]? {
        if let objects = db?.objects(GroupObject.self) {
            
            return Array(objects)
        }
        return nil
    }
    
    func getRawDataGroup() -> Results<GroupObject>? {
        if let objects = db?.objects(GroupObject.self) {
            return objects
        }
        return nil
    }
    
    func readNews() -> [NewsObject]? {
        if let objects = db?.objects(NewsObject.self) {
            
            return Array(objects)
        }
        return nil
    }
    
    func getRawDataNews() -> Results<NewsObject>? {
        if let objects = db?.objects(NewsObject.self) {
            return objects
        }
        return nil
    }
    
    func readTextNews() -> [TextNewsObject]? {
        if let objects = db?.objects(TextNewsObject.self) {
            
            return Array(objects)
        }
        return nil
    }
    
    func getRawDataTextNews() -> Results<TextNewsObject>? {
        if let objects = db?.objects(TextNewsObject.self) {
            return objects
        }
        return nil
    }
    
    
}
