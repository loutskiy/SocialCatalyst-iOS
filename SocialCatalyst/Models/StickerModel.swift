//
//  StickerModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class StickerModel {
    var productId: Int?
    var stickerId: Int!
    var images: [ImageModel]!
    var imagesWithBackground: [ImageModel]!
}
