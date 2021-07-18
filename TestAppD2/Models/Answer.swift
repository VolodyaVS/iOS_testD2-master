//
//  Answer.swift
//  TestAppD1
//
//  Created by  on 24/01/2019.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

class Answer: Decodable {
    let items: [AnswerItem]?
}

struct AnswerItem: Decodable {
    let owner: Owner?
    let score: Int?
    let lastActivityDate: Int?
    let body: String?
    let isAccepted: Bool?
}

struct Owner: Decodable {
    let displayName: String?
}
