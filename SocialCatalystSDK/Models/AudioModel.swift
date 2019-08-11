//
//  AudioModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class AudioModel {
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
}
