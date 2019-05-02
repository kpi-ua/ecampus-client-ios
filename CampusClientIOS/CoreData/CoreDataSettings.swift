//
//  CoreDataSettings.swift
//  CampusClientIOS
//
//  Created by mac on 5/1/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation

enum CoreDataEntities {
    
    case currentVote
    
    func settings() -> CoreDataSettings {
        switch self {
        case .currentVote:
            return CoreDataSettings.init(entityName: "CurrentVotes", attributeName: "votes")
        }
    }
}

struct CoreDataSettings {
    var entityName: String
    var attributeName: String
}
