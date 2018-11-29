//
//  Structs.swift
//  CampusClientIOS
//
//  Created by mac on 11/18/18.
//  Copyright © 2018 SINED. All rights reserved.
//

import Foundation

struct VoteTerms: Decodable {
    var studyTerm: StudyTerms
    var semester: String?
    var voteNumber: String?
    var id: String?
}

struct StudyTerms: Decodable {
    var start: String?
    var end: String?
}

struct AccountInfo: Decodable {
    var position : Position?
    var subdivision: Subdivision?
    var isBulletinBoardModerator: Bool
    var sid: String?
    var name: String?
    var id: String?
}

struct Position: Decodable {
    var name: String?
    var id: String?
}

struct Subdivision: Decodable {
    var name: String?
    var id: String?
}

struct PrepodToVote: Decodable {
    var employeesId: String?
    var lecturer: String?
}

