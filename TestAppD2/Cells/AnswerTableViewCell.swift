//
//  AnswerTableViewCell.swift
//  TestAppD1
//
//  Created by  on 24/01/2019.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var lastActivityDateLabel: UILabel!
    @IBOutlet weak var numberOfVotesLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    func fill(_ answer: AnswerItem?) {
        backgroundColor = UIColor.white
        
        answerLabel.attributedText = ProcessingHTML.processHTML(answer)
        authorLabel.text = answer?.owner?.display_name
        numberOfVotesLabel.text = String(format: "%li", Int(answer?.score ?? 0))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm d-MM-yyyy"
        
        if let lastActivityDate = answer?.lastActivityDate {
            lastActivityDateLabel.text = "\(dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(exactly: lastActivityDate) ?? 0.0)))"
        }
        checkImageView.isHidden = (answer?.isAccepted != nil)
    }
}
