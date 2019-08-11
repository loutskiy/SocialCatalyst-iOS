//
//  PhotoModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class PhotoModel: Mappable {
    var id: Int!
    var albumId: Int!
    var ownerId: Int!
    var photo75: String!
    var photo130: String!
    var photo604: String!
    var photo807: String?
    var photo1280: String?
    var photo2560: String?
    var width: Int!
    var height: Int!
    var text: String?
    var date: Int!
    var accessKey: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        albumId <- map["album_id"]
        ownerId <- map["owner_id"]
        photo75 <- map["photo_75"]
        photo130 <- map["photo_130"]
        photo604 <- map["photo_604"]
        photo807 <- map["photo_807"]
        photo1280 <- map["photo_1280"]
        photo2560 <- map["photo_2560"]
        width <- map["width"]
        height <- map["height"]
        text <- map["text"]
        date <- map["date"]
        accessKey <- map["access_key"]
    }
}
