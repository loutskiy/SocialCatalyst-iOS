//
//  JSONIntToAvailabilityTypeTransform.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 10/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONIntToAvailabilityTypeTransform: TransformType {
    
    typealias Object = AvailabilityType
    typealias JSON = Int
    
    init() {}
    func transformFromJSON(_ value: Any?) -> AvailabilityType? {
        if let intValue = value as? Int {
            return AvailabilityType(rawValue: intValue)
        }
        return value as? AvailabilityType ?? nil
    }
    
    func transformToJSON(_ value: AvailabilityType?) -> Int? {
        if let intValue = value {
            return intValue.rawValue
        }
        return nil
    }
}
