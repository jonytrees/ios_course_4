//
//  Session.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 01.02.2021.
//

import UIKit

struct Session {
    static var userInfo = Session()
    
    var token: String = "61eed829d6c5ab7aa04476af9cb974a21cd07c74275b39193535dcdca1d1feb6530174e75c6af817643a7" // для хранения токена в приложении
    var userId: Int = 15302998 // для хранения идентификатора пользователя в приложении
    
    private init() {}
}



