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
    
    let finishedVoteQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
    
    var openedSections: [Int: Bool] = [:]
    
    var terms: [String : VoteTerms] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
        let index = String(indexPath.row + 1)
        let title: VoteTerms = terms[index]!
        cell.textLabel?.text = "Oпитування № \(title.voteNumber!) за \(title.studyTerm.start! + "-" + title.studyTerm.end!) Н.Р."
        cell.detailTextLabel?.text = "▶︎"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension ForStudentArchiveTVC {
   
    func parseVote(json: [[String: AnyObject]]) {
        for i in 0..<json.count {
            guard let key = json[i]["id"] else { return }
            guard let start = json[i]["studyPeriod"]?["start"] else { return }
            guard let end = json[i]["studyPeriod"]?["end"] else { return }
            guard let semester = json[i]["semester"] else { return }
            guard let vote = json[i]["voteNumber"] else { return }
            let studyTerms = StudyTerms.init(start: String.init(describing: start!), end: String.init(describing: end!))
            let archiveVote = VoteTerms.init(studyTerm: studyTerms, semester: String.init(describing: semester), voteNumber: String.init(describing: vote), id: String.init(describing: key))
            self.terms.updateValue(archiveVote, forKey: String.init(describing: key))
        }
    }
    
    func finishedVotesRequest() {
        SKActivityIndicator.show("Loading", userInteractionStatus: false)
        let urlFinishedVotes = "http://api.ecampus.kpi.ua/Vote/term/finished?api_key=oauth"
        let token = UserDefaults.standard.string(forKey: "access_token")
        let auth = ["Authorization" : "Bearer " + token!]
        let requestFinished = request(urlFinishedVotes, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: auth as HTTPHeaders)
        requestFinished.responseJSON(queue: finishedVoteQueue, options: JSONSerialization.ReadingOptions.allowFragments) { (response) in
            switch(response.result) {
            case .success(let data):
                print("success")
                self.parseVote(json: data as! [[String: AnyObject]])
                print(self.terms)
                SKActivityIndicator.dismiss()
            case .failure(let error):
                print(error)
            }
        }
        /*request(urlFinishedVotes, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: auth as HTTPHeaders).responseJSON { (response) in
            switch(response.result) {
            case .success(let data):
                print("success")
                self.parseFinished(json: data as! [[String: AnyObject]])
                SKActivityIndicator.dismiss()
            case .failure(let error):
                print(error)
            }
        }*/
    }
    
    func requestVoteResultStudent(id: String, yearStart: String, yearEnd: String, semester: String) {
        let urlRequestResults = "http://api.ecampus.kpi.ua/Vote/\(id)/result?yearStart=\(yearStart)&yearEnd=\(yearEnd)&semester=\(semester)"
        print(urlRequestResults)
        let token = UserDefaults.standard.string(forKey: "access_token")
        let auth = ["Authorization" : "Bearer " + token!]
        request(urlRequestResults, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: auth as HTTPHeaders).responseJSON { (response) in
            switch(response.result) {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    
}


