//
//  AppModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 10/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class AppModel {
    var id: Int!
    var name: String!
    var photo130: String!
    var photo604: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        photo130 <- map["photo_130"]
        photo604 <- map["photo_604"]
    }
}
