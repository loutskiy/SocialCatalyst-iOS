//
//  MarketItemModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 10/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

enum AvailabilityType: Int {
    case available = 0
    case deleted = 1
    case unavailable = 2
}

class MarketItemModel {
    var id: Int!
    var ownerId: Int!
    var title: String!
    var description: String!
    var price: PriceModel!
    var category: CategoryMarketItemModel!
    var thumbPhoto: String!
    var date: Int!
    var availability: AvailabilityType!
    var isFavorite: Bool!
    var photos: [PhotoModel]?
    var canComment: Bool?
    var canRepost: Bool?
    var likes: LikesModel?
    var url: String?
    var buttonTitle: String?
}
