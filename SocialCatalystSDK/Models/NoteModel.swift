//
//  NoteModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class NoteModel {
    var id: Int!
    var ownerId: Int!
    var title: String!
    var text: String!
    var comments: Int!
    var date: Int!
    var viewUrl: String!
}
