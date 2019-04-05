//
//  StudentArchiveDetail.swift
//  CampusClientIOS
//
//  Created by Денис Ефремов on 4/4/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class StudentArchiveDetailTVC: UITableViewController {
    
    
    @IBOutlet weak var commonMarkHeaderLabel: BorderedLabel!
    @IBOutlet weak var universityCommonMarkHeaderLabel: BorderedLabel!
    @IBOutlet weak var oneCourseCommonMarkHeaderLabel: BorderedLabel!
    @IBOutlet weak var universityCommonMarkLabel: BorderedLabel!
    
    var voteData: ArchiveResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

  
}
