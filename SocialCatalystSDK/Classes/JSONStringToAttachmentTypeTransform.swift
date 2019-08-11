//
//  JSONStringToAttachmentTypeTransform.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONStringToAttachmentTypeTransform: TransformType {
    
    typealias Object = AttachmentType
    typealias JSON = String
    
    init() {}
    func transformFromJSON(_ value: Any?) -> AttachmentType? {
        if let strValue = value as? String {
            return AttachmentType(rawValue: strValue)
        }
        return value as? AttachmentType ?? nil
    }
    
    func transformToJSON(_ value: AttachmentType?) -> String? {
        if let intValue = value {
            return intValue.rawValue
        }
        return nil
    }
}
