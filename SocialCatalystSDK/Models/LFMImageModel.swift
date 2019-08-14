//
//  LFMImageModel.swift
//  SocialCatalystSDK
//
//  Created by Михаил Луцкий on 14/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class LFMImageModel: Mappable {
    
    var size: String!
    var text: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        size <- map["size"]
        text <- map["#text"]
    }
}
