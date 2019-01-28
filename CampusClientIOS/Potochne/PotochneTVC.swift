//
//  PotochneTVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/11/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class PotochneTVC: UITableViewController {
    
    let dataRequest = VoteRequest()
    let token = UserDefaults.standard.string(forKey: "access_token")
    var voteTerms: [VoteTerms]?
    var persons: [PersonToVote]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        voteData()
        personsToVote()
        tabBarSettings()
    }
    
    func tabBarSettings() {
        self.tabBarController?.tabBar.tintColor = themeColor
        self.tabBarController?.tabBar.barTintColor = themeColor
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBarController?.tabBar.selectedItem?.badgeColor = UIColor.orange
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
        dataRequest.getAllVotes(token: token) { (terms) in
            self.voteTerms = terms
            activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func personsToVote() {
        dataRequest.getPersonsForVote(token: token) { (persons) in
            self.persons = persons
            self.tableView.reloadData()
        }
    }
    
    func createHeader() -> String {
        if voteTerms != nil {
            let actualVoteNumber = voteTerms!.count - 1
            let header = "ОПИТУВАННЯ № \(voteTerms![actualVoteNumber].voteNumber!) ЗА \(voteTerms![actualVoteNumber].studyYear!)"
            return header
        }
        return ""
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = persons![indexPath.row].lecturer
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = themeColor
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
        performSegue(withIdentifier: "toVoteSegue", sender: persons![indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVoteSegue" {
            let destVC = segue.destination as! DetailTVC
            guard let person = sender as? PersonToVote else { return }
            destVC.person = person
        }
    }
    
    
    
}
