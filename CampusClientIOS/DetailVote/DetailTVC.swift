//
//  DetailTVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/11/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class DetailTVC: UITableViewController, SaveOneCriterionMark {
    
    var person: PersonToVote?
    let criterions = ["Компетентність в дисципліні, яку викладає", "Вимогливість викладача",
                      "Вміння донести матеріал до студентів",
                      "Вміння налагодити партнерські стосунки зі студентом",
                      "Загальна культура та тактовність по відношенню до студентів",
                      "Використання засобів дистанційного спілкування (електронна пошта, Skype, соцмережі)"]
    
    var marks = [0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = person?.lecturer
        tableView.allowsSelection = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if criterions == nil {
            return 0
        }
        return criterions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailVoteCell", for: indexPath) as! DetailTVCell
        cell.criteriousLabel.text = criterions[indexPath.row]
        cell.criterionID = indexPath.row + 1
        cell.buttonsOutlet()
        cell.delegate = self
        return cell
    }
    
    func saveMark(id: Int, mark: Int) {
        marks[id - 1] = mark
    }
    
    func createErrorAlert() {
        print("alert")
        let alert = UIAlertController.init(title: "Помилка", message: "Проставте всі оцінки", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkMarks() -> Bool {
        var result = false
        for i in 0..<marks.count {
            if marks[i] == 0 {
                result = true
            }
        }
        return result
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if checkMarks() == true {
            createErrorAlert()
            return
        }
    }
}
