//
//  CurrentVotes+CoreDataProperties.swift
//  
//
//  Created by Денис Ефремов on 5/8/19.
//
//

import Foundation
import CoreData


extension CurrentVotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentVotes> {
        return NSFetchRequest<CurrentVotes>(entityName: "CurrentVotes")
    }

    @NSManaged public var actuality: String?
    @NSManaged public var changeDate: String?
    @NSManaged public var dateEnd: String?
    @NSManaged public var datePublish: String?
    @NSManaged public var dateStart: String?
    @NSManaged public var id: String?
    @NSManaged public var status: String?
    @NSManaged public var studyYear: String?
    @NSManaged public var voteDescription: String?
    @NSManaged public var voteNumber: String?

}
