//
//  ForArchiveTVC.swift
//  CampusClientIOS
//
//  Created by mac on 10/27/18.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SKActivityIndicatorView

class ForStudentArchiveTVC: UITableViewController {
    
    let urlFinishedVotes = "http://api.ecampus.kpi.ua/Vote/term/finished?api_key=oauth"
    
    var openedSections: [Int: Bool] = [:]
    
    var sections: [String : FinishedVote] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        finishedVotesRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSectionOpened(section) {
            return 3
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            
            let index = String.init(describing: indexPath.row + 1)
            
            let title: FinishedVote = sections[index]!
            
            cell.textLabel?.text = (title.studyTerm.start?.description)! + "-" + (title.studyTerm.end?.description)!
            
            if isSectionOpened(indexPath.section) {
                cell.detailTextLabel?.text = "▼"
            } else {
                cell.detailTextLabel?.text = "▶︎"
            }
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = "2"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            changeSectionStatus(indexPath.section)
        }
    }
    
    func isSectionOpened(_ section: Int) -> Bool {
        if let status = openedSections[section] {
            return status
        }
        return false
    }
    
    func changeSectionStatus(_ section: Int) {
        if let status = openedSections[section] {
            openedSections[section] = !status
        }
        else {
            openedSections[section] = true
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}

extension ForStudentArchiveTVC {
    
    func finishedVotesRequest() {
        
        let archiveQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
        
        SKActivityIndicator.show("Loading", userInteractionStatus: false)
        
        let token = UserDefaults.standard.string(forKey: "access_token")
        
        let headers = ["Authorization" : "Bearer " + token!]
        
        archiveQueue.async {
            request(self.urlFinishedVotes, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers as HTTPHeaders).responseJSON { (response) in
                switch(response.result) {
                case .success(let data):
                    print("archive request")
                    let json = data as! [[String: AnyObject]]
                    for i in 0..<json.count {
                        guard let key = json[i]["id"] else { return }
                        guard let start = json[i]["studyPeriod"]?["start"] else { return }
                        guard let end = json[i]["studyPeriod"]?["end"] else { return }
                        guard let semester = json[i]["semester"] else { return }
                        guard let vote = json[i]["voteNumber"] else { return }
                        let studyTerms = StudyTerms.init(start: String.init(describing: start), end: String.init(describing: end))
                        let archiveVote = FinishedVote.init(studyTerm: studyTerms, semester: String.init(describing: semester), voteNumber: String.init(describing: vote))
                        self.sections.updateValue(archiveVote, forKey: String.init(describing: key))
                    }
                    SKActivityIndicator.dismiss()
                    print(self.sections)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        
        
    }
    
}
