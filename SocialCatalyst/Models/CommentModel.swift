//
//  CommentModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class CommentModel: Mappable {
    var id: Int!
    var fromId: Int!
    var date: Int!
    var text: String!
    var likes: LikesModel?
    var attachments: [AttachmentModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        fromId <- map["from_id"]
        date <- map["date"]
        text <- map["text"]
        likes <- map["likes"]
        attachments <- map["attachments"]
    }
}
