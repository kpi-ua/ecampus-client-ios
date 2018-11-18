//
//  Structs.swift
//  CampusClientIOS
//
//  Created by mac on 11/18/18.
//  Copyright © 2018 SINED. All rights reserved.
//

import Foundation

struct FinishedVote: Decodable {
    var studyTerm: StudyTerms
    var semester: String?
    var voteNumber: String?
}

struct StudyTerms: Decodable {
    var start: String?
    var end: String?
}
    
