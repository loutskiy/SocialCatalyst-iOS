//
//  BackgroundModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 08/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

enum BackgroundType: String {
    case gradient = "gradient"
    case tile = "tile"
}

class BackgroundModel {
    var id: Int!
    var type: BackgroundType!
    var angle: Int?
    var color: String!
    var width: Int?
    var height: Int?
}
