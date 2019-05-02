//
//  PotochneTVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/11/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class PotochneTVC: UITableViewController {
    
    let dataRequest = VoteRequest(apiClient: ApiClient.shared)
    let token = UserDefaults.standard.string(forKey: "access_token")
    var voteTerms: [VoteTerms]?
    var persons: [PersonToVote]?
    let segueID = "voteSegue"
    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        voteData()
        personsToVote()
        tabBarSettings()
    }
    
    func tabBarSettings() {
        self.tabBarController?.tabBar.barTintColor = UIColor.ThemeColor.themeColor
        self.tabBarItem.selectedImage = UIImage.init(named: "icons8-todo_list_filled")
    }

    func setUpIndicator() -> ActivityIndicatorView {
        let y = self.view.frame.height / 2
        let x = self.view.frame.width / 2
        let cgPoint = CGPoint.init(x: x, y: y)
        let activityIndicator = ActivityIndicatorView.init(title: "", center: cgPoint)
        return activityIndicator
    }
    
    func voteData() {
        let activityIndicator = setUpIndicator()
        activityIndicator.startAnimating()
        voteTerms = dataManager.allVotes
        tableView.reloadData()
//        dataRequest.getAllVotes() { (terms) in
//            self.voteTerms = terms
//            activityIndicator.stopAnimating()
//            self.tableView.reloadData()
//        }
    }
    
    func personsToVote() {
        persons = dataManager.personsToVote
        tableView.reloadData()
//        dataRequest.getPersonsForVote() { (persons) in
//            self.persons = persons
//            self.tableView.reloadData()
//        }
    }
    
    func createHeader() -> String {
        /*if voteTerms != nil {
            let actualVoteNumber = voteTerms!.count - 1
            let header = "ОПИТУВАННЯ № \(voteTerms![actualVoteNumber].voteNumber!) ЗА \(voteTerms![actualVoteNumber].studyYear!)"
            return header
        }*/
        return ""
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = persons![indexPath.row].lecturer
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.ThemeColor.themeColor
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor.white
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return createHeader()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if persons != nil {
            return persons!.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "voteSegue", sender: self.persons![indexPath.row])
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "voteSegue" {
            let destVC = segue.destination as! DetailTVC
            guard let person = sender as? PersonToVote else { return }
            destVC.person = person
        }
    }
    
}
