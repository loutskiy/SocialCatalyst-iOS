//
//  AudioModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class AudioModel: Mappable {
    var id: Int!
    var ownerId: Int!
    var artist: String!
    var title: String!
    var duration: Int!
    var url: String!
    var lyricsId: Int?
    var albumId: Int?
    var genreId: Int?
    var date: Int!
    var noSearch: Bool?
    var isHQ: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        ownerId <- map["owner_id"]
        artist <- map["artist"]
        title <- map["title"]
        duration <- map["duration"]
        url <- map["url"]
        lyricsId <- map["lyrics_id"]
        albumId <- map["album_id"]
        genreId <- map["genre_id"]
        date <- map["date"]
        noSearch <- map["no_search"]
        isHQ <- map["is_hq"]
    }
}
