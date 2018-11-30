//
//  DetailVoteTVC.swift
//  CampusClientIOS
//
//  Created by mac on 17.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailVoteTVC: UITableViewController {
    
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    
    var prepodDetailName: PrepodToVote?
    let cellIdentifier = "voteDetaliCell"
    var currentSelection: IndexPath = [-1]
    var currentVote: VoteTerms?
    var voteDetails = [String]()
    var prepodMarks = [Int]()
    let date = Date.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = prepodDetailName!.lecturer
        saveButtonOutlet.tintColor = UIColor.white
        makePrepodMarksArray()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DetailVoteTVCell {
            cell.detalilVoteLabel.text = voteDetails[indexPath.row]
            cell.index = indexPath.row
            cell.viewController = self
            return cell
        }
        return UITableViewCell()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voteDetails.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.currentSelection = [indexPath.row]
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func getmark(mark: Int, index: Int) {
        prepodMarks[index] = mark
    }
    
    @IBAction func saveVoteButton(_ sender: Any) {
        let choose = checkMarksForZeros()
        chooseAlert(choose: choose)
        print("save button \(prepodMarks)")
    }
    
    func createOKAlert() {
        let alert = UIAlertController.init(title: "Оцінка за \(prepodDetailName)", message:"збережена успішно і є конфіденційною" , preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) in
            print("saved")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func createWarningAlert() {
        let alert = UIAlertController.init(title: "Проставте всі оцінки", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkMarksForZeros() -> Bool {
        for i in 0..<prepodMarks.count {
            if prepodMarks[i] == 0 {
                return true
            }
        }
        return false
    }
    
    func chooseAlert(choose: Bool) {
        if choose == true {
            createWarningAlert()
        }
        else {
            createOKAlert()
        }
    }
    
    func makePrepodMarksArray() {
        for _ in 0..<voteDetails.count {
            prepodMarks.append(0)
        }
    }
    
    func postMarks(marks: [Int]) {
        let token = UserDefaults.standard.string(forKey: "access_token")
        let auth = ["Authorization" : "Bearer " + token!,
                    "Content-Type": "application/x-www-form-urlencoded"]
        let parameters = ["voteTermId" : currentVote?.id,
                          "employeeId" : prepodDetailName?.lecturer,
                          "dateVote" : date.description,
                          "actuality" : "true",
                          "changeDate" : date.description,
                          "personalityId" : "",
                          "voteCriterionId" : "",
                          "course" : "",
                          "mark" : ""] as [String : Any]
        for i in 0...voteDetails.count {
            
        }
    }
    
}






