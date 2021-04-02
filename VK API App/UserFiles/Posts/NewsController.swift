//
//  NewsController.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 21.03.2021.
//

import UIKit
import RealmSwift

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var news: [NewsStruct] = []
//    var comments: [CommentStruct] = []
//    var commentsRealm: [CommentStruct] = []
//    var commentsObject: [CommentsObject] = []
    var newsRealm: [NewsStruct] = []
    var newsObject: [NewsObject] = []
    var textNew: [TextNewsStruct] = []
    var newsTextRealm: [TextNewsStruct] = []
    var newsTextObject: [TextNewsObject] = []
    var token = Session.userInfo.token
    var userId = Session.userInfo.userId
    var version = "5.130"
    private var tokenRealm: NotificationToken?
    private var tokenTextRealm: NotificationToken?
   
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        

        
        if let url = URL(string: "https://api.vk.com/method/newsfeed.get?count=10&access_token=\(token)&v=\(version)") {
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                let json = try? ((JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String: AnyObject])
                let main = json!["response"]
                let groups = main!["groups"]
                let items = main!["items"]
                print("items: \(items)")
                
                do{
                    let groupsData = try JSONSerialization.data(withJSONObject: groups!!)

                    self.news = try JSONDecoder().decode([NewsStruct].self, from: groupsData)
                    
                    let itemsData = try JSONSerialization.data(withJSONObject: items!!)
                    
                    
                    
                    self.textNew = try JSONDecoder().decode([TextNewsStruct].self, from: itemsData)
                    
                    let dateNewsArray = Databases().readNews()
                    let textNewsArray = Databases().readTextNews()
                    dateNewsArray?.forEach({self.news.append($0.toNewsStruct())})
                    textNewsArray?.forEach({self.textNew.append($0.toTextNewsStruct())})

                    DispatchQueue.main.async {
                        self.addGroupDatabase()
                        self.tableview.reloadData()
                    }
                }
                catch{
                    print(error)
                }
            }
            task.resume()
        }
        
        tokenRealm = Databases().getRawDataNews()?.observe({(changes) in
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
                self.newsObject = data
                break
            case .error(let error):
                print(error)
                break
            default:
                break
            }
        })
        
        tokenTextRealm = Databases().getRawDataTextNews()?.observe({(changes) in
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
                self.newsTextObject = data
                break
            case .error(let error):
                print(error)
                break
            default:
                break
            }
        })
        
        
    }
    
    func addGroupDatabase() {
        let db = Databases()
        newsRealm.forEach({db.writeNews($0.toNewsObject())})
        newsTextRealm.forEach({db.writeTextNews($0.toTextNewsObject())})
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewsCell
//        let date = news[indexPath.row].date
//        let name = news[indexPath.row].name
//        let photo = news[indexPath.row].photo_100
//        let text = textNew[indexPath.row].text

        
//        let comments = textNew[indexPath.row].comments?.count
//        print("comments: \(comments)")
//        cell.setDataPost(name: name, photo: photo, text: text ?? "", comment: 0)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
