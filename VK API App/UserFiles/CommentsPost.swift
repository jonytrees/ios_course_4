//
//  CommentsPost.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 23.03.2021.
//

import Foundation
import RealmSwift

struct APIResponse: Decodable {
//    var results: [CommentStruct]
}

class NetWork {
    private var tokenRealm: NotificationToken?
    
//    var comments: [Comments] = []
    let urlString =  "https://api.vk.com/method/newsfeed.getComments?count=1&access_token=\(Session.userInfo.token)&v=5.130"


//    func getComments(handler: @escaping (([CommentStruct]) -> Void)) {
//        
//        guard let url = URL(string: urlString) else {
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if data != nil && error == nil {
//                let apiResponse = try? JSONDecoder().decode(APIResponse.self, from: data!)
//                print("jsonComment: \(apiResponse)")
//                if apiResponse != nil {
//                    let characters = apiResponse!.results
//                    handler(characters)
//                } else {
//                    print("json parse error")
//                }
//            } else {
//                print("network error")
//            }
//        }.resume()
//        
//    }

}
