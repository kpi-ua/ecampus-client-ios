//
//  PotochneTVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/11/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class PotochneTVC: UITableViewController {
    
    let dataRequest = DataRequest()
    let defaults = UserDefaults.standard
    var voteTerms: [VoteTerms]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        voteData()
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
        let token = defaults.string(forKey: "access_token")
        dataRequest.getAllVotes(token: token) { (terms) in
            self.voteTerms = terms
            activityIndicator.stopAnimating()
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return createHeader()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
}
