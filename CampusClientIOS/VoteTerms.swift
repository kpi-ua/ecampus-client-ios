//
//  VoteTerms.swift
//  CampusClientIOS
//
//  Created by mac on 1/10/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation

struct VoteTerms: Codable {
    var id: String?
    var studyYear: String?
    var voteNumber: String?
    var voteDescription: TermsCase?
    var dateStart: String?
    var dateEnd: String?
    var actuality: String?
    var changeDate: String?
    var datePublish: String?
    
    enum TermsCase: String, CodingKey, Codable {
        case voteNumber
    }
    
}
