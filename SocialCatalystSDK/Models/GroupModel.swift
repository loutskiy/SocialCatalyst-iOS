//
//  GroupModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class GroupModel: Mappable {
    var id: Int!
    var name: String!
    var screenName: String?
    var photo50: String?
    var photo100: String?
    var photo200: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        screenName <- map["screen_name"]
        photo50 <- map["photo_50"]
        photo100 <- map["photo_100"]
        photo200 <- map["photo_200"]
    }
}
