//
//  AttachmentModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

enum AttachmentType: String {
    case photo = "photo"
    case link = "link"
    case unknown
}

class AttachmentModel: Mappable {
    var type: AttachmentType!
    var photo: PhotoModel?
    var link: LinkModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        type <- (map["type"], JSONStringToAttachmentTypeTransform())
        photo <- map["photo"]
        link <- map["link"]
    }
}

