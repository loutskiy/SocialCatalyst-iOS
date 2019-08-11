//
//  JSONIntToWhoCanViewTypeTransform.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONIntToWhoCanViewTypeTransform: TransformType {
    
    typealias Object = WhoCanType
    typealias JSON = Int
    
    init() {}
    func transformFromJSON(_ value: Any?) -> WhoCanType? {
        if let intValue = value as? Int {
            return WhoCanType(rawValue: intValue)
        }
        return value as? WhoCanType ?? nil
    }
    
    func transformToJSON(_ value: WhoCanType?) -> Int? {
        if let intValue = value {
            return intValue.rawValue
        }
        return nil
    }
}
