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
}
