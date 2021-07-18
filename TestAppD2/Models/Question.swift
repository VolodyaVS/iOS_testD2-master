//
//  Question.swift
//  TestAppD1
//
//  Created by  on 24/01/2019.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

struct Question: Decodable {
    let items: [Item]?
}

struct Item: Decodable {
    let owner: Owner?
    let answer_count: Int?
    let question_id: Int?
    let last_activity_date: Int?
    let title: String?
    var smartDateFormat: String? {
        Item.timeAgoString(from: Date.init(timeIntervalSince1970: TimeInterval(exactly: self.last_activity_date!)!))
    }

    static func timeAgoString(from date: Date?) -> String? {
        var timeAgoString = ""

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full

        let now = Date()
        let calendar = Calendar.current
        var components: DateComponents

        if let aDate = date {
            components = calendar.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute, .second], from: aDate, to: now)
            
            if components.year! > 0 {
                formatter.allowedUnits = .year
            } else if components.month! > 0 {
                formatter.allowedUnits = .month
            } else if components.weekOfMonth! > 0 {
                formatter.allowedUnits = .weekOfMonth
            } else if components.day! > 0 {
                formatter.allowedUnits = .day
            } else if components.hour! > 0 {
                formatter.allowedUnits = .hour
            } else if components.minute! > 0 {
                formatter.allowedUnits = .minute
            } else {
                formatter.allowedUnits = .second
            }
            timeAgoString = "  \(formatter.string(from: components) ?? "") ago"

            return timeAgoString
        }
        return timeAgoString
    }
}

struct Owner: Decodable {
    let display_name: String?
}
