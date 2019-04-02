//
//  ArchiveDataModel.swift
//  CampusClientIOS
//
//  Created by mac on 3/28/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation

class ArchiveDataModel {
    
    private let voteRequest = VoteRequest.init(apiClient: ApiClient.shared)
    private let token = UserDefaults.standard.string(forKey: "access_token")
    
    var allVotes: [VoteTerms]?
    var resultsForSpecificTerm: [[ArchiveResults]]?
    
    init() {
        getVotes { (result) in
            self.allVotes = result
            self.makeArchiveList()
        }
    }
    
    private func getVotes(_ completion: @escaping ([VoteTerms]?) -> Void) {
        guard token != nil else { return }
        voteRequest.getAllVotes(token: token) { (terms) in
            completion(terms)
        }
    }
    
    private func makeArchiveList() {
        for vote in allVotes! {
            getResultForSpecificVote(termID: vote.id!) { (result) in
                print(result[0])
            }
        }
    }
    
    private func getResultForSpecificVote(termID: String, completion: @escaping ([ArchiveResults]) -> Void) {
        guard token != nil else { return }
        voteRequest.archiveRequest(termID: termID) { (results) in
            completion(results)
        }
    }
    
    
    
}
