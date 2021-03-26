//
//  ViewController.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 01.02.2021.
//

import UIKit
import WebKit
//import Firebase
//import FirebaseDatabase
class ViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
//    private var handler: AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7801665"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,wall,groups,photos"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.52")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.handler = Auth.auth().addStateDidChangeListener({ (auth, user) in
//            if user != nil {
//                self.performSegue(withIdentifier: "Profile", sender: nil)
//            print("user is not nil")
//            }
//        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        Auth.auth().removeStateDidChangeListener(handler)
    }
}




extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        let token = params["access_token"]
        let user_id = params["user_id"]
        Session.userInfo.token = token!
        Session.userInfo.userId = Int(user_id!)!
        
        print("ACCESS_TOKEN \(token!)")
        print("USER ID \(user_id!)")
        
        performSegue(withIdentifier: "Profile", sender: nil)
        
        decisionHandler(.cancel)
    }
}



