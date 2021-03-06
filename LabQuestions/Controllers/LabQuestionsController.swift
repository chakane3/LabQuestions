//
//  LabQuestionsController.swift
//  LabQuestions
//
//  Created by Chakane Shegog on 11/10/21.
//

import UIKit

class LabQuestionsController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    // set up our data based of Question model
    private var questions = [Question]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadQuestions()
    }
    
    private func loadQuestions() {
        LabQuestionsAPIClient.fetchQuestions { [weak self] result in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App error", message: "\(appError)")
                }
                
            case .success(let questions):
                self?.questions = questions
            }
        }
    }
}

extension LabQuestionsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
        let question = questions[indexPath.row]
        cell.textLabel?.text = question.title
        return cell
    }
}
