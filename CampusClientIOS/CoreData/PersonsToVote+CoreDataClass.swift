//
//  PersonsToVote+CoreDataClass.swift
//  
//
//  Created by Денис Ефремов on 5/8/19.
//
//

import Foundation
import CoreData

@objc(PersonsToVote)
public class PersonsToVote: NSManagedObject, Codable {
    
    @NSManaged var id: String
    @NSManaged var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "employeesId", name = "lecturer"
    }
    
    public required convenience init() {
        
    }
}
