//
//  studentArchiveVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/23/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class studentArchiveVC: UITableViewController {

    let voteReq = VoteRequest.init(apiClient: ApiClient.shared)

    let defaults = UserDefaults.standard
    var votes = [VoteTerms]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestVotes()
    }
    
    func requestVotes() {
        guard let token = defaults.string(forKey: "access_token") else { return }
        voteReq.getAllVotes(token: token) { (terms) in
            self.votes = terms
            self.tableView.reloadData()
        }
    }
    
    //Data and design for table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return votes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if votes == [] {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentArchCell", for: indexPath) as! ArchiveMainCell
        cell.textLabel?.text = "ОПИТУВАННЯ № \(votes[indexPath.row].voteNumber!) ЗА \(votes[indexPath.row].studyYear!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   

}
