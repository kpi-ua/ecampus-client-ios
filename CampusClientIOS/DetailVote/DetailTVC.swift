//
//  DetailTVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/11/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class DetailTVC: UITableViewController {

    var person: PersonToVote?
    var criterions: [String]?
    let dataRequest = DataRequest.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = person?.lecturer
        getCriterions()
    }
    
    func getCriterions() {
        dataRequest.getCriterious { (gotCriterions) in
            print(gotCriterions)
            self.criterions = gotCriterions
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if criterions == nil {
            return 0
        }
        return criterions!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailVoteCell", for: indexPath) as! DetailTVCell
        cell.criteriousLabel.text = criterions![indexPath.row]
        return cell
    }


    
    
    
}
