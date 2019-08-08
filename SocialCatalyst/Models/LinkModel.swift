//
//  LinkModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class LinkModel: Mappable {
    var url: String!
    var title: String!
    var caption: String?
    var description: String!
    var isExternal: Bool?
    var photo: PhotoModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        url <- map["url"]
        title <- map["title"]
        caption <- map["caption"]
        description <- map["description"]
        isExternal <- map["is_external"]
        photo <- map["photo"]
    }
}

