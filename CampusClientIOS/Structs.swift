//
//  PersonClass.swift
//  CampusClientIOS
//
//  Created by mac on 1/11/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation

struct PersonToVote: Codable {
    var id: String?
    var lecturer: String?
}

struct Criterion: Codable {
    var id: String?
    var name: String?
}

struct lecturerResult: Codable {
    var id: String?
    var lecturer: String?
    var course: String?
    var voteCriterionID: String?
    var voteCriterionName: String?
    var voteCriterionCoef: String?
    var mark: String?
}

struct AccountInfoS: Encodable {
    var position: Position?
    var subdivision: Subdivision?
    var isBulletinBoardModerator: String?
    var sid: String?
    var name: String?
    var id: String?
}

struct Position: Encodable {
    var name: String?
    var id: String?
}

struct Subdivision: Encodable {
    var name: String?
    var id: String?
}
