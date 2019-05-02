//
//  DataManager.swift
//  CampusClientIOS
//
//  Created by Денис Ефремов on 4/5/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation

final class DataManager {
    
    static let shared: DataManager = DataManager.init()
    
    private let coreDataManager = CoreDataManager.init()
    private let voteRequest = VoteRequest.init(apiClient: ApiClient.shared)
    private let accountInfo = AccountInfo.init(apiClient: ApiClient.shared)
    private let dataParser = DataParser.init()
    
    private(set) var allVotes: [VoteTerms]?
    private(set) var personsToVote: [PersonToVote]?
    
    private typealias completion<T> = (T) -> Void
    
    private init() {
        print("DATA MANAGER INIT")
        getAllVotes { (data) in
            print("ALL VOTES")
            self.allVotes = data
        }
        getPersons { (data) in
            print("PERSONS")
            self.personsToVote = data
        }
    }
    
    private func getAllVotes(completion: @escaping completion<[VoteTerms]>) {
        voteRequest.getAllVotes { (data) in
            completion(data)
        }
    }
    
    private func getPersons(completion: @escaping completion<[PersonToVote]>) {
        voteRequest.getPersonsForVote { (data) in
            completion(data)
        }
    }
    
}
