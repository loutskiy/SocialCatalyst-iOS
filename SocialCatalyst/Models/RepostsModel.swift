//
//  RepostsModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class RepostsModel: Mappable {
    var count: Int!
    var userReposted: Int!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        userReposted <- map["user_reposted"]
    }
}
