//
//  AnswerModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class AnswerModel: Mappable {
    var id: Int!
    var text: String!
    var votes: Int!
    var rating: Double!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        text <- map["text"]
        votes <- map["votes"]
        rating <- map["rating"]
    }
}
