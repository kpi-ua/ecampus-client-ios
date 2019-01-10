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

class DataRequest: NSObject {
    
    private let defaults = UserDefaults.standard
    private let requsetBgQ = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
    
    public func tokenRequest(login: String, password: String, completion: @escaping (String) -> Void) {
        let authURL = "http://api.ecampus.kpi.ua/oauth/token"
        let headers = ["Content-Type" : "application/x-www-form-urlencoded",
                       "Accept" : "application/json"]
        let parameters = ["username" : login,
                          "password" : password,
                          "grant_type" : "password"]
        requsetBgQ.async {
            request(authURL, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
                switch(response.result) {
                case .success(let data) :
                    let json = data as! [String : AnyObject]
                    if let token = json["access_token"] as? String {
                        mainQ.async {
                            completion(token)
                        }
                    } else {
                        completion("")
                    }
                case .failure(let error) :
                    print(error)
                }
            }
        }
    }
    
    public func getAllVotes(token: String?, completion: @escaping ([VoteTerms]) -> Void) {
        let url = "http://api.ecampus.kpi.ua/Vote/Terms"
        let auth = ["Authorization" : "Bearer " + token!]
        requsetBgQ.async {
            request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: auth).responseJSON { (response) in
                switch(response.result) {
                case .success(let data):
                    let json = data as! [[String : AnyObject]]
                    let terms = self.parseTerms(json: json)
                    mainQ.async {
                        completion(terms)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    public func getPersonsForVote(token: String?) {
        let url = "http://api.ecampus.kpi.ua/Vote/Persons"
        
        
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
    
    
    
}
