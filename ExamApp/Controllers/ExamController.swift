//
//  ExamController.swift
//  MVC-Exam-Questions
//
//  Created by Mohammad Azam on 9/3/18.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class ExamController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddQuestionDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var questions: [Question] = [Question]()
    
    private let questionService = QuestionnService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.questions = questionService.getAll()
        self.tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nc = segue.destination as? UINavigationController else { return }
        guard let addQuestionTVC = nc.viewControllers.first as? AddQuestionTableViewController else { return }
        
        addQuestionTVC.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.questions[indexPath.row].text
        
        return cell
    }
    
    func addQuestionDidSaveQuestion(question: Question, controller: UIViewController) {
        questionService.add(question: question)
        controller.dismiss(animated: true)
        
        self.questions = questionService.getAll()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func addQuestionDidClose(controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}
