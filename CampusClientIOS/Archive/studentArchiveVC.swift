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

    private let defaults = UserDefaults.standard
    
    var dataModel: ArchiveDataModel?
    
    var votes = [VoteTerms]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel = ArchiveDataModel.init()
    }
    
    private final func tabBarSettings() {
        self.tabBarController?.tabBar.barTintColor = themeColor
        self.tabBarItem.selectedImage = UIImage.init(named: "icons8-book_filled")
    }
    
    //Data and design for table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return votes.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentArchCell", for: indexPath) as! ArchiveMainCell
        cell.titleLabel?.text = "ОПИТУВАННЯ № \(votes[indexPath.row].voteNumber!) ЗА \(votes[indexPath.row].studyYear!) р."
        let arrowIMG = UIImage.init(named: "icons8-chevron_right_filled")
        cell.arrowPicture?.image = arrowIMG
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    
}
