//
//  Endpoints.swift
//  CampusClientIOS
//
//  Created by Денис Ефремов on 5/2/19.
//  Copyright © 2019 SINED. All rights reserved.
//

enum APIEndpoint: String {
    
    case allVotes = "Vote/Terms"
    case persons = "Vote/Persons"
    case accountInfo = "Account/Info"
    case studentGroup = "Account/student/group"
    case studentResults
    
    func foo() -> String {
        return String()
    }
    
}
