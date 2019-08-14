//
//  PageModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

enum WhoCanType: Int {
    case all = 2
    case participants = 1
    case admins = 0
}

class PageModel {
    var id: Int!
    var groupId: Int!
    var creatorId: Int!
    var title: String!
    var currentUserCanEdit: Bool!
    var currentUserCanEditAccess: Bool!
    var whoCanView: WhoCanType!
    var whoCanEdit: WhoCanType!
    var edited: Int!
    var created: Int!
    var editorId: Int!
    var views: Int!
    var parent: String?
    var parent2: String?
    var source: String?
    var html: String?
    var viewUrl: String!
    
    required init() {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        groupId <- map["group_id"]
        creatorId <- map["creator_id"]
        title <- map["title"]
        currentUserCanEdit <- map["current_user_can_edit"]
        currentUserCanEditAccess <- map["current_user_can_edit_access"]
        whoCanView <- map["who_can_view"]
        whoCanEdit <- map["who_can_edit"]
        edited <- map["edited"]
        created <- map["created"]
        editorId <- map["editor_id"]
        views <- map["views"]
        parent <- map["parent"]
        parent2 <- map["parent2"]
        source <- map["source"]
        html <- map["html"]
        viewUrl <- map["view_url"]
    }
}
