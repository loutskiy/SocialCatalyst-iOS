//
//  TopicModel.swift
//  SocialCatalystSDK
//
//  Created by Михаил Луцкий on 13/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class TopicModel {
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
}
