//
//  PotochneTVC.swift
//  CampusClientIOS
//
//  Created by mac on 08.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PotochneTVC: UITableViewController {
    
    let navColor = UIColor.init(hexString: "#0277bd")
    var prepodi = [PrepodToVote]()
    var sections = [VoteTerms]()
    let cellIdentifier = "voteCell"
    var criterions = [String]()
    var currentSelection: Int?
    var currentVote: VoteTerms?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarSettings()
        tableView.estimatedRowHeight = 60
        tableView.layoutIfNeeded()
        tableView.rowHeight = UITableViewAutomaticDimension
        requestForCriterions()
        self.tableView.sectionHeaderHeight = 40
        self.tableView.tableHeaderView?.backgroundColor = navColor
        self.tableView.tableHeaderView?.tintColor = navColor
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prepodi.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VoteTVCell
        let text = prepodi[indexPath.row].lecturer!
        cell.prepodNameLabel.text = text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        currentSelection = indexPath.row
        performSegue(withIdentifier: "detailVoteSegue", sender: nil)
        tableView.beginUpdates()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return setHeight(index: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let voteNumber = sections[section].voteNumber!
        let start = sections[section].studyTerm.start!
        let end = sections[section].studyTerm.end!
        return "Опитування № \(voteNumber) за \(start) - \(end) Н.Р."
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    private func setHeight(index: IndexPath) -> CGFloat {
        return 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailVoteSegue") {
            if let DetailVoteTVC = segue.destination as? DetailVoteTVC {
                DetailVoteTVC.prepodDetailName = prepodi[currentSelection!]
                DetailVoteTVC.voteDetails = self.criterions
                DetailVoteTVC.currentVote = self.sections[0]
            }
        }
    }
    
    func requestForCriterions() {
        request("http://api.ecampus.kpi.ua/Vote/Criterions", method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            switch(response.result) {
            case.success(let data) :
                let json = data as! [NSDictionary]
                for i in 0...json.count - 1 {
                    self.criterions.append(json[i]["name"] as! String)
                }
            case.failure(let error):
                print("error \(error)")
            }
        }
    }
    
    
    
    func tabBarSettings() {
        self.tabBarController?.tabBar.tintColor = navColor
        self.tabBarController?.tabBar.barTintColor = navColor
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBarController?.tabBar.selectedItem?.badgeColor = UIColor.orange
    }
    
}


