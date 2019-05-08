//
//  DataManager.swift
//  CampusClientIOS
//
//  Created by Денис Ефремов on 4/5/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let shared: DataManager = DataManager.init()
    
    private let coreDataManager = CoreDataManager.init()
    private let dataParser = DataParser.init()
    private let voteRequest = VoteRequest.init(apiClient: ApiClient.shared)
    private let accountInfo = AccountInfo.init(apiClient: ApiClient.shared)
    
    private(set) var allVotes: [VoteTerms]?
    private(set) var personsToVote: [PersonToVote]?
    private(set) var archiveResults: [ArchiveResults]?
    
    private typealias completion<T> = (T) -> Void
    
    private init() {
        getAllVotes { (data) in
            
        }
        getPersons { (data) in
            self.personsToVote = data
        }
    }
    
    private func getAllVotes(completion: @escaping completion<[CurrentVotes]>) {
        voteRequest.getAllVotes { (data) in
            print(data)
            guard let result = self.dataParser.parseData(data: data, type: [CurrentVotes].self) else { return }
            completion(result)
        }
    }
    
    private func getPersons(completion: @escaping completion<[PersonToVote]>) {
        voteRequest.getPersonsForVote { (data) in
            print(data)
            guard let result = self.dataParser.parseData(data: data, type: Array<PersonToVote>.self) else { return }
            completion(result)
        }
    }
    
    private func archiveResult(termID: String, completion: @escaping completion<[ArchiveResults]>) {
        voteRequest.archiveRequest(termID: termID) { (data) in
            guard let result = self.dataParser.parseData(data: data, type: Array<ArchiveResults>.self) else { return }
            completion(result)
        }
    }
    
}

