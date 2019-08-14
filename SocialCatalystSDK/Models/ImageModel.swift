//
//  ImageModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

enum ImageType: String {
    case s = "s"
    case m = "m"
    case x = "x"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case y = "y"
    case z = "z"
    case w = "w"
}

class ImageModel {
    var url: String!
    var width: Int!
    var height: Int!
    var type: ImageType?
    
    required init() {
        
    }
    
    func mapping(map: Map) {
        url <- map["url"]
        width <- map["width"]
        height <- map["height"]
        type <- (map["type"], JSONStringToImageTypeTransform())
    }
}
