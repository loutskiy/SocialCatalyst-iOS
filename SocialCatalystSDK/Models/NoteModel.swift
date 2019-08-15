//
//  NoteModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class NoteModel: Mappable {
    var id: Int!
    var ownerId: Int!
    var title: String!
    var text: String!
    var comments: Int!
    var date: Int!
    var viewUrl: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        ownerId <- map["owner_id"]
        title <- map["tittle"]
        text <- map["text"]
        comments <- map["comments"]
        date <- map["date"]
        viewUrl <- map["view_url"]
    }
}
