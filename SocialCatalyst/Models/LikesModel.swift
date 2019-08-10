//
//  LikesModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class LikesModel: Mappable {
    var count: Int!
    var userLikes: Bool!
    var canLike: Bool?
    var canPublish: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        userLikes <- map["user_likes"]
        canLike <- map["can_like"]
        canPublish <- map["can_publish"]
    }
}
