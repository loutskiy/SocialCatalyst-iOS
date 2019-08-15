//
//  TopicModel.swift
//  SocialCatalystSDK
//
//  Created by Михаил Луцкий on 13/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class TopicModel: Mappable {
    var id: Int!
    var title: String!
    var created: Int!
    var createdBy: Int!
    var updated: Int!
    var updatedBy: Int!
    var isClosed: Bool!
    var isFixed: Bool!
    var comments: Int!
    var firstComment: String?
    var lastComment: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        created <- map["created"]
        createdBy <- map["created_by"]
        updated <- map["updated"]
        updatedBy <- map["updated_by"]
        isClosed <- map["is_closed"]
        isFixed <- map["is_fixed"]
        comments <- map["comments"]
        firstComment <- map["first_comment"]
        lastComment <- map["last_comment"]
    }
}
