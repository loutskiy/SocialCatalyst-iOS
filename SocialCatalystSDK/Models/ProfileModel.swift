//
//  ProfileModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileModel: Mappable {
    var id: Int!
    var firstName: String?
    var secondName: String?
    var sex: Int?
    var screenName: String?
    var photo50: String?
    var photo100: String?
    var online: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["first_name"]
        secondName <- map["last_name"]
        sex <- map["sex"]
        screenName <- map["screen_name"]
        photo50 <- map["photo_50"]
        photo100 <- map["photo_100"]
        online <- map["online"]
    }
}
