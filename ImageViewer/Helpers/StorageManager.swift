//
//  StorageManager.swift
//  StorageManager
//
//  Created by Roman Kiruxin on 18.02.2022.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func createImageList(images: Image) -> ImageList {
        
        let imageList = ImageList()
        imageList.total = images.total
        imageList.totalHits = images.totalHits
        
        for imageNumber in 0 ..< images.hits.count {
            
            let image = ImageRealm()
            
            image.id = images.hits[imageNumber].id
            image.type = images.hits[imageNumber].type
            image.tags = images.hits[imageNumber].tags
            image.webformatWidth = images.hits[imageNumber].webformatWidth
            image.webformatHeight = images.hits[imageNumber].webformatHeight
            image.downloads = images.hits[imageNumber].downloads
            image.user = images.hits[imageNumber].user
            image.date = Date()
            
            guard let imageUrl = URL(string: images.hits[imageNumber].webformatURL) else { return imageList}
            guard let imageData = try? Data(contentsOf: imageUrl) else { return imageList}
            image.imageFromWebUrl = imageData
            imageList.images.append(image)
        }
        return imageList
    }
    
    static func saveImagesList(images: ImageList) {
        
        try! realm.write {
            realm.add(images)
            }
    }

    static func editList(imagesList: ImageList, newImageList: ImageList) {
        try! realm.write {
            let images = imagesList.images
            realm.delete(images)
            realm.delete(imagesList)
            realm.add(newImageList)
        }
    }
}
