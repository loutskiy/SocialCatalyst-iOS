//
//  DocumentModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

enum DocumentType: Int {
    case text = 1
    case archive = 2
    case gif = 3
    case image = 4
    case audio = 5
    case video = 6
    case book = 7
    case undefined = 8
}

class DocumentModel {
    var id: Int!
    var ownerId: Int!
    var title: String!
    var size: Int!
    var ext: String!
    var url: String!
    var date: Int!
    var type: DocumentType!
}
