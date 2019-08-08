//
//  PostModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 03/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class PostModel: Mappable {
    
    var text: String!
    var postType: String!
    var markedAsAds: Bool!
    var id: Int!
    var date: Int!
    var ownerId: Int!
    var fromId: Int!
    var postSource: String!
    var attachments: [AttachmentModel]?
    var comments: CommentsModel!
    var likes: LikesModel!
    var reposts: RepostsModel!
    var copyHistory: [PostModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        text <- map["text"]
        postType <- map["post_type"]
        markedAsAds <- map["marked_as_ads"]
        id <- map["id"]
        date <- map["date"]
        ownerId <- map["owner_id"]
        fromId <- map["from_id"]
        attachments <- map["attachments"]
        comments <- map["comments"]
        likes <- map["likes"]
        reposts <- map["reposts"]
        copyHistory <- map["copy_history"]
    }
}
