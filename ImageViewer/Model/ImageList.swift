//
//  ImageList.swift
//  ImageList
//
//  Created by Roman Kiruxin on 18.02.2022.
//

import RealmSwift

class ImageList: Object {
    @objc dynamic var total  = 0
    @objc dynamic var totalHits = 0
    var images = List<ImageRealm>()
}
