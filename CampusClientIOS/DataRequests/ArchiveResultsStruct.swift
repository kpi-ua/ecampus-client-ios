//
//  ArchiveResultsClass.swift
//  CampusClientIOS
//
//  Created by mac on 3/28/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation


struct ArchiveResults: Codable {
    var employeeId: Int
    var fullName: String
    var universityMark: Double
    var courseMark: [CourseMark]
    var avgCriteriaForCourse: [AvgCriteriaForCourse]
    var yearMark: [YearMark]
}

struct CourseMark: Codable {
    var course: Int
    var mark: Double
    var voicesCount: Int
}

struct AvgCriteriaForCourse: Codable {
    var criterionId: Int
    var mark: Double
}

struct YearMark: Codable {
    var year: String
    var mark: Double
}




