//
//  ProfileTVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/29/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewController {

    let acountInfoReq = AccountInfo.init(apiClient: ApiClient.shared)
    let sections = ["Персональні дані", "Дані за місцем навчання (роботи)", "Контакти"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Мій профіль"
        acountInfoReq.getAccountInfo { (info) in
            print(info)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   

}
