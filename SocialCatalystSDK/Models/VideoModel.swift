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
    
    required init() {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        ownerId <- map["owner_id"]
        title <- map["tiitle"]
        description <- map["description"]
        duration <- map["duration"]
        photo130 <- map["photo_130"]
        photo320 <- map["photo_320"]
        photo640 <- map["photo_640"]
        photo800 <- map["photo_800"]
        photo1280 <- map["photo_1280"]
        firstFrame130 <- map["first_frame_130"]
        firstFrame320 <- map["first_frame_320"]
        firstFrame640 <- map["first_frame640"]
        firstFrame800 <- map["first_frame_800"]
        firstFrame1280 <- map["first_frame_1280"]
        date <- map["date"]
        addingDate <- map["adding_date"]
        views <- map["views"]
        comments <- map["comments"]
        player <- map["player"]
        platform <- map["platform"]
        canEdit <- map["can_edit"]
        canAdd <- map["can_add"]
        isPrivate <- map["is_private"]
        accessKey <- map["access_key"]
        proccessing <- map["proccessing"]
        live <- map["live"]
        upcoming <- map["upcoming"]
        isFavourite <- map["is_favourite"]
    }
}
