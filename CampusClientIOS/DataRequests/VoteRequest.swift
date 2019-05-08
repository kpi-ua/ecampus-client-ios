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
import CoreData

class VoteRequest: NSObject {

    private var apiClient : ApiClient
    private let defaults = UserDefaults.standard
    private let requsetBgQ = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
    typealias completion = (Any) -> Void
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
        super.init()
    }

    public func getAllVotes(completion: @escaping completion) {
        requsetBgQ.async {
            self.apiClient.makeRequest("Vote/Terms", method: .get, parameters: nil) { (data) in
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
    }

    public func getPersonsForVote(completion: @escaping completion) {
        requsetBgQ.async {
            self.apiClient.makeRequest("Vote/Persons", { (data) in
                    DispatchQueue.main.async {
                        completion(data)
                    }
            })
        }
    }

    public func studentResultsRequest(token: String, termID: String, completion: @escaping completion) {
        let url = "Vote/Results/Students?voteTermId=\(termID)"
        requsetBgQ.async {
            self.apiClient.makeRequest(url, method: .get, parameters: nil) { (data) -> Void in
                completion(data)
            }
        }
    }
    
    public func archiveRequest(termID : String, completion: @escaping completion) {
        let url = "Vote/\(termID)/archive"
        requsetBgQ.async {
            self.apiClient.makeRequest(url, method: .get, parameters: nil, { (data) in
                DispatchQueue.main.async {
                    completion(data)
                }
            })
        }
    }
    
    
    
}
