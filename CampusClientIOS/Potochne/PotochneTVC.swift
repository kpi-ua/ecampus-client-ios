//
//  PotochneTVC.swift
//  CampusClientIOS
//
//  Created by mac on 08.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit

class PotochneTVC: UITableViewController {
    
    let voteCell = VoteTVCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "voteCell")
    
    let prepodi: [String] = ["prepod0", "prepod1", "prepod2", "prepod3", "prepod4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return prepodi.count
    }

   /* override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let cell = tableView.dequeueReusableCell(withIdentifier: "voteCell", for: indexPath)
        let item = prepodi[indexPath.row]
        return 0
    }*/

    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "voteCell", for: indexPath)
        //let item = prepodi[indexPath.row]
        
        let cell

        return cell
    }*/

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
