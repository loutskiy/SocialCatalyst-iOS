//
//  VideoModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class VideoModel {
    var id: Int!
    var ownerId: Int!
    var title: String!
    var description: String!
    var duration: Int!
    var photo130: String!
    var photo320: String!
    var photo640: String?
    var photo800: String?
    var photo1280: String?
    var firstFrame130: String!
    var firstFrame320: String!
    var firstFrame640: String?
    var firstFrame800: String?
    var firstFrame1280: String?
    var date: Int!
    var addingDate: Int!
    var views: Int!
    var comments: Int!
    var player: String!
    var platform: String?
    var canEdit: Bool?
    var canAdd: Bool!
    var isPrivate: Bool?
    var accessKey: String?
    var proccessing: Bool?
    var live: Bool?
    var upcoming: Bool?
    var isFavourite: Bool!
}
