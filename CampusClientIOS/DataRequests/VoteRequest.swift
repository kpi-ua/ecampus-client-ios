//
//  DataRequest.swift
//  CampusClientIOS
//
//  Created by mac on 1/9/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VoteRequest: NSObject {


    private var apiClient : ApiClient

    private let defaults = UserDefaults.standard
    private let requsetBgQ = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)

    init(apiClient: ApiClient) {
        self.apiClient = apiClient

        super.init()
    }


    public func getAllVotes(token: String?, completion: @escaping ([VoteTerms]) -> Void) {
        requsetBgQ.async {

            self.apiClient.makeRequest("Vote/Terms", method: .get, parameters: nil) { (data) -> Void in
                let json = data as! [[String: AnyObject]]
                let terms = self.parseTerms(json: json)
                mainQ.async {
                    completion(terms)
                }
            }
        }
    }


    public func getPersonsForVote(token: String?, completion: @escaping ([PersonToVote]) -> Void) {
    }

    public func getCriterious(completion: @escaping ([String]) -> Void) {

        requsetBgQ.async {

            self.apiClient.makeRequest("Vote/Criterions", method: .get, parameters: nil) { (data) -> Void in
                let json = data as! [[String : AnyObject]]
                let criterions = self.parseCriterions(json: json)
                mainQ.async {
                    completion(criterions)
                }
            }
        }
    }

    public func studentResultsRequest(token: String, termID: String, completion: @escaping ([[String : AnyObject]]) -> Void) {

        let url = "Vote/Results/Students?voteTermId=\(termID)"
        
        ApiClient.shared

        requsetBgQ.async {
            self.apiClient.makeRequest(url, method: .get, parameters: nil) { (data) -> Void in
                print(data)
                let json = data as! [[String : AnyObject]]
                completion(json)
            }
        }
    }

    private func parseStudResults(json: [[String : AnyObject]]) {
        print(json)
    }

    private func parseCriterions(json: [[String : AnyObject]]) -> [String] {
        var criterions = [String]()
        for i in 0..<json.count {
            var crit = String.init()
            guard let name = json[i]["name"] as? String else { return [String]() }
            crit = name
            criterions.append(crit)
        }
        return criterions
    }

    private func parsePersons(json: [[String : AnyObject]]) -> [PersonToVote] {
        var persons = [PersonToVote]()
        for i in 0..<json.count {
            var person = PersonToVote.init(id: nil, lecturer: nil)
            guard let id = json[i]["employeesId"] as? String else { return [PersonToVote]() }
            person.id = id
            guard let lecturer = json[i]["lecturer"] as? String else { return [PersonToVote]() }
            person.lecturer = lecturer
            if person.lecturer!.hasSuffix(", ") {
                person.lecturer!.removeLast(2)
            }
            persons.append(person)
        }
        return persons
    }

    private func parseTerms(json: [[String : AnyObject]]) -> [VoteTerms] {
        var terms = [VoteTerms]()
        for i in 0..<json.count {
            let term = VoteTerms.init()
            guard let studyYear = json[i]["studyYear"] as? String else { return [VoteTerms]() }
            term.studyYear = studyYear
            guard let voteNumber = json[i]["voteNumber"] as? String else { return [VoteTerms]() }
            term.voteNumber = voteNumber
            guard let desc = json[i]["description"] as? String else { return [VoteTerms]() }
            term.voteDescription = desc
            guard let dateStart = json[i]["dateStart"] as? String else { return [VoteTerms]() }
            term.dateStart = dateStart
            guard let dateEnd = json[i]["dateEnd"] as? String else { return [VoteTerms]() }
            term.dateEnd = dateEnd
            guard let actuality = json[i]["actuality"] as? String else { return [VoteTerms]() }
            term.actuality = actuality
            guard let changeDate = json[i]["changeDate"] as? String else { return [VoteTerms]() }
            term.changeDate = changeDate
            guard let datePublish = json[i]["datePublish"] as? String else { return [VoteTerms]() }
            term.datePublish = datePublish
            terms.append(term)
        }
        return terms
    }


    public func sendMarks(voteTermId: String, employeeID: String, personalityID: String, course: String, mark: String, termId: String) {
    }

/*[
 {
 "voteTermId": 7,
 "employeeId": 39811,
 "dateVote": "2018-11-18T15:00:17.382Z",
 "actuality": true,
 "changeDate": "2018-11-18T15:00:17.382Z",
 "personalityId": 10252,
 "voteCriterionId": 1,
 "course": 3,
 "mark": 1
 }
 ]
  */
}
