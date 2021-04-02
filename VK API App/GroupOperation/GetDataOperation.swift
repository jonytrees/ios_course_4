//
//  GetDataOperation.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 29.03.2021.
//

import Foundation

class GetDataOperation: AsyncOperation {

    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
    
    private var url: URLRequest
    private var dataTask: URLSessionDataTask?
    var data: Data?
    
    override func main() {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            self?.data = data
            self?.state = .finished
        }.resume()
    }
    
    init(request: URLRequest) {
        self.url = request
        super.init()
    }
    
}

