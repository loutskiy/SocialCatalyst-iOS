//
//  CommentsModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class CommentsModel: Mappable {
    var count: Int!
    var canPost: Bool!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        canPost <- map["can_post"]
    }
}
