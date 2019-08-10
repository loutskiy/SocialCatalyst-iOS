//
//  MarketAlbumModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class MarketAlbumModel {
    var id: Int!
    var ownerId: Int!
    var title: String!
    var photo: PhotoModel!
    var count: Int!
    var updatedTime: Int!
}
