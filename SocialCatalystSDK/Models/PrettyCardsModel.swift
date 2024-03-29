//
//  PrettyCardsModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class PrettyCardsModel: Mappable {
    
    var cards: [PrettyCardModel]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cards <- map["cards"]
    }
}
