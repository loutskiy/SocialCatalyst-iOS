//
//  ArrayModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class ArrayModel<T: Mappable>: Mappable {
    var count: Int!
    var items: [T]!
    var profiles: [ProfileModel]?
    var groups: [GroupModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        items <- map["items"]
        profiles <- map["profiles"]
        groups <- map["groups"]
    }
}
