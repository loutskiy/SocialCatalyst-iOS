//
//  PollModel.swift
//  SocialCatalyst
//
//  Created by Михаил Луцкий on 07/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class PollModel {
    var id: Int!
    var ownerId: Int!
    var created: Int!
    var question: String!
    var votes: Int!
    var answers: [AnswerModel]!
    var anonymous: Bool!
    var multiple: Bool!
    var answerIds: [Int]!
    var endDate: Int!
    var closed: Bool!
    var isBoard: Bool!
    var canEdit: Bool!
    var canVote: Bool!
    var canReport: Bool!
    var canShare: Bool!
    var authorId: Int!
    var photo: PhotoModel!
    var friends: [Int]!
    var background: BackgroundModel!
}
