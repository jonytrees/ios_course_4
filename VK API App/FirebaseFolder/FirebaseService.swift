//
//  FirebaseService.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 01.03.2021.
//

import Foundation
import FirebaseDatabase

class FirebaseService {
    
    static var shared: FirebaseService = FirebaseService()
    
//    private var ref: DatabaseReference?
    
    private init() {
//        ref = Database.database().reference()
    }
    
   
    func pullIdAndGroups(nameUser: String, id: String, name: [String]){
        let infoUser = FairbaseNameGroup(nameUser: nameUser, id: id, name: name)
//        ref?.child(id).setValue(infoUser.toDictGroup())
    }
}
