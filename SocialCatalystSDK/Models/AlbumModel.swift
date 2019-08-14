//
//  AlbumModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class AlbumModel {
    var id: Int!
    var thumb: PhotoModel!
    var ownerId: Int!
    var title: String!
    var description: String!
    var created: Int!
    var updated: Int!
    var size: Int!
    
    required init() {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        thumb <- map["thumb"]
        ownerId <- map["owner_id"]
        title <- map["title"]
        description <- map["description"]
        created <- map["created"]
        updated <- map["updated"]
        size <- map["size"]
    }
}
