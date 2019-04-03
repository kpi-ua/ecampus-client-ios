//
//  studentArchiveVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/23/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit
import Foundation

struct expandableCell {
    var opened: Bool
    var title: VoteTerms
    var data: [ArchiveResults]
}

class studentArchiveVC: UITableViewController, DataReceiveProtocol {
    
    private let defaults = UserDefaults.standard
    
    var dataModel: ArchiveDataModel?
    
    //var results: [[VoteTerms : [ArchiveResults]]] = []
    
    var tableViewData = [expandableCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel = ArchiveDataModel.init()
        dataModel?.dataDelegate = self
    }
    
    private final func tabBarSettings() {
        self.tabBarController?.tabBar.barTintColor = themeColor
        self.tabBarItem.selectedImage = UIImage.init(named: "icons8-book_filled")
    }
    
    //Data and design for table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].data.count + 1
        } else {
            return 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentArchCell") as? ArchiveMainCell else { return UITableViewCell() }
            cell.titleLabel.text = "ОПИТУВАННЯ № \(tableViewData[indexPath.section].title.voteNumber) ЗА \(tableViewData[indexPath.section].title.studyYear) р."
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentExpandedCell") else { return UITableViewCell() }
            cell.textLabel?.text = tableViewData[indexPath.section].data[indexPath.row - 1].fullName
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
        performSegue(withIdentifier: "toDetailInfo", sender: nil)
    }
    
    func dataReceive(vote: VoteTerms, result: [ArchiveResults]) {
        tableViewData.append(expandableCell.init(opened: false, title: vote, data: result))
        tableView.reloadData()
    }
    
}
