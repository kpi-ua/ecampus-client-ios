//
//  PersonsToVote+CoreDataProperties.swift
//  
//
//  Created by Денис Ефремов on 5/8/19.
//
//

import Foundation
import CoreData


extension PersonsToVote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonsToVote> {
        return NSFetchRequest<PersonsToVote>(entityName: "PersonsToVote")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
