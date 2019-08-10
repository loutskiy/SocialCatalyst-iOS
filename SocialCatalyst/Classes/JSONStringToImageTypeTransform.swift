//
//  JSONStringToImageTypeTransform.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 09/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONStringToImageTypeTransform: TransformType {
    
    typealias Object = ImageType
    typealias JSON = String
    
    init() {}
    func transformFromJSON(_ value: Any?) -> ImageType? {
        if let strValue = value as? String {
            return ImageType(rawValue: strValue)
        }
        return value as? ImageType ?? nil
    }
    
    func transformToJSON(_ value: ImageType?) -> String? {
        if let intValue = value {
            return intValue.rawValue
        }
        return nil
    }
}
