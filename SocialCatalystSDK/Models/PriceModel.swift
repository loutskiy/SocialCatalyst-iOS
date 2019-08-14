//
//  PriceModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 10/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class PriceModel {
    var amount: Int!
    var currency: CurrencyModel!
    var text: String!
    
    required init() {
        
    }
    
    func mapping(map: Map) {
        amount <- map["amount"]
        currency <- map["currency"]
        text <- map["text"]
    }
}
