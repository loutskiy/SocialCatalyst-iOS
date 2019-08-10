//
//  PrettyCardModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class PrettyCardModel {
    var cardId: Int!
    var linkUrl: String!
    var title: String!
    var images: [ImageModel]!
    var price: String!
    var priceOld: String!
    var button: String!
}
