//
//  CategoryMarketItemModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 10/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryMarketItemModel: Mappable {
    
    var id: Int!
    var name: String!
    var section: SectionModel!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        section <- map["section"]
    }
}
