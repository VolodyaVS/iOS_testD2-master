//
//  ProcessingHTML.swift
//  TestAppD2
//
//  Created by Vladimir Stepanchikov on 24.07.2021.
//  Copyright © 2021 Григорий Соловьев. All rights reserved.
//

import UIKit

class ProcessingHTML {
    static func processHTML(_ answer: AnswerItem?) -> NSMutableAttributedString {
        var answerBody = answer?.body

        let attributedString = NSMutableAttributedString(string: answer?.body ?? "")
        let pattern = "<code>[^>]+</code>"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let matches = regex?.matches(
            in: answerBody ?? "",
            options: [],
            range: NSRange(location: 0, length: answerBody?.count ?? 0)
        )

        for match in matches ?? [] {
            attributedString.addAttribute(
                .backgroundColor,
                value: UIColor(red: 0,
                               green: 110.0 / 255.0,
                               blue: 200.0 / 255.0,
                               alpha: 0.5),
                range: match.range)

            if let aSize = UIFont(name: "Courier", size: 17) {
                attributedString.addAttribute(.font, value: aSize, range: match.range)
            }
        }

        var cycle = true

        while cycle {
            if let aSearch = (answerBody as NSString?)?.range(of: "<[^>]+>", options: .regularExpression), aSearch.location != NSNotFound {
                attributedString.removeAttribute(.backgroundColor, range: aSearch)
                attributedString.replaceCharacters(in: aSearch, with: "\n")
                answerBody = (answerBody as NSString?)?.replacingCharacters(in: aSearch, with: "\n")
            } else {
                cycle = false
            }
        }
        return attributedString
    }
}
