//
//  EventModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

enum MemberStatus: Int {
    case yes
    case maybe
    case no
}

class EventModel: Mappable {
    var id: Int!
    var time: Int!
    var memberStatus: MemberStatus!
    var isFavorite: Bool!
    var address: String?
    var text: String?
    var buttonText: String?
    var friends: [Int]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        time <- map["time"]
        memberStatus <- map["member_status"]
        isFavorite <- map["is_favorite"]
        address <- map["address"]
        text <- map["text"]
        buttonText <- map["button_text"]
        friends <- map["friends"]
    }
}
