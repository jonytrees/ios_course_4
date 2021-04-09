//
//  GroupFileManager.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 09.04.2021.
//

import Foundation
import Alamofire


class PhotoService {
    
    // определяет время в секундак в течение которого кеш считается актуальным
    let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    // папка в которой будут сохранятся изображения
    static let pathName: String = {
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    // получает на вход URL изображения и возвращает на его основе путь к файлу для сохранения или загрузки
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hasName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hasName).path
    }
    
    
    // сохраняет изображение в файловой системе
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    
    // загружает изображение из файловой системы и при этом проводит ряд проверок
    private func getImageFromCache(url: String) -> UIImage? {
       guard let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date else {return nil}
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
      guard lifeTime <= cacheLifeTime,
             let image = UIImage(contentsOfFile: fileName) else {return nil}
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        
        return image
    }
    
    
    private func updateImageFromCache() {
        for image in 0...self.images.count {
            let info = try? FileManager.default.attributesOfItem(atPath: image)
            print("info: \(info)")
        }
    }
    
    
    // словарь в котором будут храниться загруженные и извлеченные из файловой системы изображения
    private var images = [String: UIImage]()
    
    
    // загружает фото из сети
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: .global()) { [weak self] response in
            guard let data = response.data,
            let image = UIImage(data: data) else {return}
            
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            
            self?.saveImageToCache(url: url, image: image)
            
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath)
            }
            
        }
    }
    
    
    // предоставляет изображение по URL. При этом ищем изображение сначала в кеше, потом в файловой системе, если его нигде нет, загружаем из сети
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        
        return image
    }
    
    
    // для хранения обертки
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    
}


// протокол, декларирующий всего один метод — reloadRow
fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}


// Table — первый класс, имплементирующий протокол DataReloadable. В него будет заворачиваться UITableView
extension PhotoService {
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
}



