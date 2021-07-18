//
//  DetailViewController.swift
//  TestAppD1
//
//  Created by  on 24/01/2019.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!

    // MARK: - Public Properties
    var refreshControl: UIRefreshControl!
    var activityIndicatorView: UIActivityIndicatorView!
    var answers: [AnswerItem]! = [AnswerItem()]
    var currentQuestion: Item!

    // MARK: - Private Properties
    private let questionCellID = "CellForQuestion"
    private let answerCellID = "CellForAnswer"

    // MARK: - Override methods
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil),
                           forCellReuseIdentifier: answerCellID)
        tableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: questionCellID)

        addRefreshControlOnTabelView()
        settingDynamicHeightForCell()
        addActivityIndicator()
    }

    // MARK: - Public methods
    func loadAnswers() {
        FabricRequest.request(withQuestionID: currentQuestion.question_id!) { data in
            self.reload(inTableView: data)
        }
    }

    func addActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .gray

        let bounds: CGRect = UIScreen.main.bounds

        activityIndicatorView.center = CGPoint(x: bounds.size.width / 2, y:
                                                bounds.size.height / 2)
        activityIndicatorView.hidesWhenStopped = true

        view.addSubview(activityIndicatorView)
    }
    
    func addRefreshControlOnTabelView() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.reloadData),
                                  for: .valueChanged)
        refreshControl?.backgroundColor = UIColor.white

        if let aControl = refreshControl {
            tableView.addSubview(aControl)
        }
    }

    @objc func reloadData() {
        tableView.reloadData()
        if refreshControl != nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"

            let title = "Last update: \(formatter.string(from: Date()))"
            let attrsDictionary = [NSAttributedString.Key.foregroundColor : UIColor.black]
            let attributedTitle = NSAttributedString(string: title,
                                                     attributes: attrsDictionary)

            refreshControl?.attributedTitle = attributedTitle
            refreshControl?.endRefreshing()
        }
    }
    
    func settingDynamicHeightForCell() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func reload(inTableView jsonData: Data?) {
        answers = [AnswerItem]()

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        if let answerModel = try? decoder.decode(Answer.self, from: jsonData!) {
            answers = answerModel.items
        }

        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        })
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if answers.count == 0 {
            activityIndicatorView.startAnimating()
        }
        return answers.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: questionCellID,
                                                     for: indexPath) as! QuestionTableViewCell
            cell.fill(currentQuestion)

            titleNavigationItem.title = currentQuestion.title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: answerCellID,
                                                     for: indexPath) as! AnswerTableViewCell

            let answer = answers?[indexPath.row - 1]

            cell.fill(answer)
            return cell
        }
    }
}
