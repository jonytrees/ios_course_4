//
//  Photo.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 12.02.2021.
//

import UIKit
import RealmSwift

class PhotoController: UIViewController {
    var token = Session.userInfo.token
    var userId = Session.userInfo.userId
    var version = "5.52"
    var photoData: [PhotoStruct] = []
    var photoObject: [PhotoObject] = []
    private var tokenRealm: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        tokenRealm = Databases().getRawDataPhoto()?.observe({(changes) in
            switch changes {
            case .initial(let initial):
                UIView.animate(withDuration: 0.6, delay: 0.0, options: [.autoreverse]) {
                    self.view.backgroundColor = .black
                } completion: {(_) in
                
                }
                print(initial)
                break
            case .update(let res, deletions: [], insertions: [], modifications: []):
                let data = Array(res)
                self.photoObject = data
                break
            case .error(let error):
                print(error)
                break
            default:
                break
            }
        })
    }
    
    private func addPhotoDatabase() {
        let db = Databases()
        photoData.forEach({db.writePhoto($0.toPhotoObject())})
    }
    
    func getData()  {
        
        if let url = URL(string: "https://api.vk.com/method/photos.getAll?extended=\(userId)&fields=bdate&access_token=\(token)&v=\(version)") {
            let session = URLSession.shared
            
            
            let task = session.dataTask(with: url) { (data, response, error) in
                do{
                    let json = try? (JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as? [String: AnyObject]
                    let main_first = json!["response"]
                    
                    let items =  main_first!["items"]
                    
                    let itemsData = try JSONSerialization.data(withJSONObject: items!!)
                    
                    let photoDecoder = try JSONDecoder().decode([PhotoStruct].self, from: itemsData)
                    self.photoData = photoDecoder
                    self.addPhotoDatabase()
                    
                    let photoArray = Databases().readPhoto()
                    photoArray?.forEach({self.photoData.append($0.toPhotoStruct())})
                    for photo in self.photoData {
                        DispatchQueue.main.async {
                            let xWidth = Int.random(in: 0...Int(self.view.frame.width))
                            let yHeight = Int.random(in: 0...Int(self.view.frame.height))
                            let imageUrl = photo.photo_1280
                            let url = URL(string: imageUrl)
                            let data = try? Data(contentsOf: url!)
                            var imageView: UIImageView
                            imageView = UIImageView(frame:CGRect(x: xWidth, y: yHeight, width: 150, height: 150));
                            imageView.image = UIImage(data: data!)
                            self.view.addSubview(imageView)
                            
                        }
                    }
                }
                catch{
                    print(error)
                }
            }
            task.resume()
        }
    }
}



