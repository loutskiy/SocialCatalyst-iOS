//
//  JSONIntToMemberStatusTransform.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONIntToMemberStatusTransform: TransformType {
    
    typealias Object = MemberStatus
    typealias JSON = Int
    
    init() {}
    func transformFromJSON(_ value: Any?) -> MemberStatus? {
        if let intValue = value as? Int {
            return MemberStatus(rawValue: intValue)
        }
        return value as? MemberStatus ?? nil
    }
    
    func transformToJSON(_ value: MemberStatus?) -> Int? {
        if let intValue = value {
            return intValue.rawValue
        }
        return nil
    }
}
