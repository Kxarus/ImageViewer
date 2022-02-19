//
//  Image.swift
//  Image
//
//  Created by Roman Kiruxin on 17.02.2022.
//

struct Image: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [ImageDetail]
}

struct ImageDetail: Decodable {
    let id: Int
    let type: String
    let tags: String
    let webformatURL: String
    let webformatWidth: Int
    let webformatHeight: Int
    let downloads: Int
    let user: String
}

