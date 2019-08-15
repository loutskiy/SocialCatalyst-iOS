//
//  StickerModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class StickerModel: Mappable {
    var productId: Int?
    var stickerId: Int!
    var images: [ImageModel]!
    var imagesWithBackground: [ImageModel]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        productId <- map["product_id"]
        stickerId <- map["sticker_id"]
        images <- map["images"]
        imagesWithBackground <- map["images_with_background"]
    }
}
