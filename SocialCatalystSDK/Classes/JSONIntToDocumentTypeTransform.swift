//
//  JSONIntToDocumentTypeTransform.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONIntToDocumentTypeTransform: TransformType {
    
    typealias Object = DocumentType
    typealias JSON = Int
    
    init() {}
    func transformFromJSON(_ value: Any?) -> DocumentType? {
        if let intValue = value as? Int {
            return DocumentType(rawValue: intValue)
        }
        return value as? DocumentType ?? nil
    }
    
    func transformToJSON(_ value: DocumentType?) -> Int? {
        if let intValue = value {
            return intValue.rawValue
        }
        return nil
    }
}
