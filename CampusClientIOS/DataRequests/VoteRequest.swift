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
    private let decoder = JSONDecoder()

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
        super.init()
    }

    public func getAllVotes(completion: @escaping ([VoteTerms]) -> Void) {
        requsetBgQ.async {
            self.apiClient.makeRequest("Vote/Terms", method: .get, parameters: nil) { (data) in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let terms = try! self.decoder.decode(Array<VoteTerms>.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(terms)
                    }
                } catch let err {
                    print("Err", err.localizedDescription)
                }
            }
        }
    }

    public func getPersonsForVote(completion: @escaping ([PersonToVote]) -> Void) {
        requsetBgQ.async {
            self.apiClient.makeRequest("Vote/Persons", { (data) in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let persons = try! self.decoder.decode(Array<PersonToVote>.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(persons)
                    }
                } catch let err {
                    print("Err", err)
                }
                
            })
        }
    }

    public func studentResultsRequest(token: String, termID: String, completion: @escaping ([[String : AnyObject]]) -> Void) {
        let url = "Vote/Results/Students?voteTermId=\(termID)"
        requsetBgQ.async {
            self.apiClient.makeRequest(url, method: .get, parameters: nil) { (data) -> Void in
                let json = data as! [[String : AnyObject]]
                completion(json)
            }
        }
    }
    
    public func archiveRequest(termID : String, completion: @escaping ([ArchiveResults]) -> Void) {
        let url = "Vote/\(termID)/archive"
        requsetBgQ.async {
            self.apiClient.makeRequest(url, method: .get, parameters: nil, { (data) in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let results = try! self.decoder.decode(Array<ArchiveResults>.self, from: jsonData)
                    completion(results)
                } catch {
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    
    
}
