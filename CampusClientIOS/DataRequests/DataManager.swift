//
//  DataManager.swift
//  CampusClientIOS
//
//  Created by Денис Ефремов on 4/5/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation


class DataManager {
    
    private static var uniqueInstance: DataManager?
    
    let voteRequest = VoteRequest.init(apiClient: ApiClient.shared)
    let accountInfo = AccountInfo.init(apiClient: ApiClient.shared)
    
    private(set) static var allVotes: [VoteTerms]?
    private(set) static var personsToVote: [PersonToVote]?
    private(set) static var archiveResults: [ArchiveResults]?
    
    typealias completion<T> = (T) -> Void
    
    private init() {
        getCurrentVotes { (votes) in
            DataManager.allVotes = votes
        }
        getPersonsToVote { (persons) in
            DataManager.personsToVote = persons
        }
    }
    
    static func shared() -> DataManager {
        guard uniqueInstance != nil else { return uniqueInstance! }
        uniqueInstance = DataManager.init()
        return uniqueInstance!
    }
    
    private func getCurrentVotes(completion: @escaping  completion<[VoteTerms]>) {
        voteRequest.getAllVotes { (votes) in
            completion(votes)
        }
    }
    
    private func getPersonsToVote(completion: @escaping completion<[PersonToVote]>) {
        voteRequest.getPersonsForVote { (persons) in
            completion(persons)
        }
    }
    
//    private func getArchiveResults(completion: @escaping completion<[ArchiveResults]>) {
//        voteRequest.archiveRequest(termID: "") { (results) in
//
//        }
//    }

    
    
    
    
    
    
}
