//
//  ImageRealm.swift
//  ImageRealm
//
//  Created by Roman Kiruxin on 18.02.2022.
//

import RealmSwift

class ImageRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var type = ""
    @objc dynamic var tags = ""
    @objc dynamic var imageFromWebUrl = Data()
    @objc dynamic var webformatWidth = 0
    @objc dynamic var webformatHeight = 0
    @objc dynamic var downloads = 0
    @objc dynamic var user = ""
    
    @objc dynamic var date = Date()
}
