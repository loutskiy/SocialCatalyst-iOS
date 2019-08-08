//
//  JSONStringToBackgroundTypeTransform.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 08/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONStringToBackgroundTypeTransform: TransformType {
    
    typealias Object = BackgroundType
    typealias JSON = String
    
    init() {}
    func transformFromJSON(_ value: Any?) -> BackgroundType? {
        if let strValue = value as? String {
            return BackgroundType(rawValue: strValue)
        }
        return value as? BackgroundType ?? nil
    }
    
    func transformToJSON(_ value: BackgroundType?) -> String? {
        if let intValue = value {
            return intValue.rawValue
        }
        return nil
    }
}
