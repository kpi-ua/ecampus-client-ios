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

class ForArchiveTVC: UITableViewController {

    let urlVoteTerms = "http://api.ecampus.kpi.ua/Vote/term/finished?api_key=oauth"
    
    var openedSections: [Int: Bool] = [:]
    
    var sections: [String : Any] = [:]
    var voteID: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        voteListRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sections)
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
            
            cell.textLabel?.text = "Опитування № \(voteID[indexPath.row]) за \(sections.index(forKey: voteID[indexPath.row]))"
            
            if isSectionOpened(indexPath.section) {
                cell.detailTextLabel?.text = "▼"
            }
            else {
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


extension ForArchiveTVC {
    
    func voteListRequest() {
        
        SKActivityIndicator.show("Loading", userInteractionStatus: false)
        
        let token = UserDefaults.standard.string(forKey: "access_token")
        
        let headers = ["Authorization" : "Bearer " + token!]
        
        request(urlVoteTerms, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers as HTTPHeaders).responseJSON { (response) in
            switch(response.result) {
            case .success(let data):
                print(data)
                let json = data as! [[String: AnyObject]]
                for i in 0..<json.count {
                    guard let key = json[i]["id"] else { return }
                    guard let semesterValue = json[i]["semester"] else { return }
                    guard let studyPeriod = json[i]["studyPeriod"] else { return }
                    let value = [semesterValue, studyPeriod]
                    let activeKey = String.init(describing: key)
                    self.sections.updateValue(value, forKey: activeKey)
                    self.voteID.append(activeKey)
                }
                SKActivityIndicator.dismiss()
                print(self.sections.count)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
}
