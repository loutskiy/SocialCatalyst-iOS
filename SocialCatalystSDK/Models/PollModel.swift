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
    
    required init() {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        ownerId <- map["onwer_id"]
        created <- map["created"]
        question <- map["question"]
        votes <- map["votes"]
        answers <- map["answers"]
        anonymous <- map["anonymous"]
        multiple <- map["multiple"]
        answerIds <- map["answer_id"]
        endDate <- map["end_date"]
        closed <- map["closed"]
        isBoard <- map["is_board"]
        canEdit <- map["can_edit"]
        canVote <- map["can_vote"]
        canReport <- map["can_report"]
        canShare <- map["can_share"]
        authorId <- map["author_id"]
        photo <- map["photo"]
        friends <- map["friends"]
        background <- map["background"]
    }
}
