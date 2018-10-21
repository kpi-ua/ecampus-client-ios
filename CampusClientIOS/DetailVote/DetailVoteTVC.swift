//
//  DetailVoteTVC.swift
//  CampusClientIOS
//
//  Created by mac on 17.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit

class DetailVoteTVC: UITableViewController {
    
    var prepodDetailName = ""
    let cellIdentifier = "voteDetaliCell"
     var currentSelection = [[-1], [-1]]
    
    let voteDetails = [ "Компетенстність в дисципліні, яку викладає",
                        "Вимогливість викладача",
                        "Вміння донести матеріал до студентів",
                        "Вміння налагодиди партнерські стосунки зі студентами",
                        "Загальна культура та тактовність по відношенню до студентів",
                        "Використання засобів дистанційного спілкування (електронна пошта, Skype, соцмережі)"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = prepodDetailName
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DetailVoteTVCell {
            cell.detalilVoteLabel.text = voteDetails[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.currentSelection = [[indexPath.section], [indexPath.row]]
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return voteDetails.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return setHeight(index: indexPath)
    }
    
    private func setHeight(index: IndexPath) -> CGFloat {
        if [[index.section], [index.row]] == self.currentSelection {
            if tableView.cellForRow(at: index)?.frame.size.height == 150 {
                return 95
            }
            return 150
        }
        return 95
    }
    
    
}
