//
//  PotochneTVC.swift
//  CampusClientIOS
//
//  Created by mac on 08.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit
import UIDropDown

class PotochneTVC: UITableViewController {
    
    let prepodi = [
        ["prepod0", "prepod1", "prepod2", "prepod3", "prepod4"],
        ["prepod5", "prepod6", "prepod7", "prepod8"]
        ]
    let sectionNames = ["vote 1", "vote 2"]
    let cellIdentifier = "voteCell"
    var currentSelection = [[-1], [-1]]
    var selectedPrepod = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prepodi[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VoteTVCell
        cell.prepodNameLabel.text = prepodi[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        tableView.beginUpdates()
        self.currentSelection = [[indexPath.section], [indexPath.row]]
        selectedPrepod = currentPrepod(index: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return setHeight(index: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section \(self.sectionNames[section])"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return prepodi.count
    }
    
    private func setHeight(index: IndexPath) -> CGFloat {
        if [[index.section], [index.row]] == self.currentSelection {
            if tableView.cellForRow(at: index)?.frame.size.height == 100 {
                return 60
            }
            return 100
        }
            return 60
    }
    
    func currentPrepod(index: IndexPath) -> String {
        let currentPrepod = prepodi[index.section][index.row]
        return currentPrepod
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailVoteSegue") {
            if let DetailVoteTVC = segue.destination as? DetailVoteTVC {
                DetailVoteTVC.prepodDetailName = selectedPrepod
            }
        }
    }
}
