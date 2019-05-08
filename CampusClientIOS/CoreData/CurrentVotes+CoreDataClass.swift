//
//  CurrentVotes+CoreDataClass.swift
//  
//
//  Created by Денис Ефремов on 5/8/19.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey.init(rawValue: "DataModel")
}

public class CurrentVotes: NSManagedObject, Codable {
    
    @NSManaged public var id: String?
    @NSManaged public var studyYear: String?
    @NSManaged public var voteNumber: String?
    @NSManaged public var voteDescription: String?
    @NSManaged public var dateStart: String?
    @NSManaged public var dateEnd: String?
    @NSManaged public var actuality: String?
    @NSManaged public var changeDate: String?
    @NSManaged public var datePublish: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, studyYear, voteNumber, voteDescription = "description", dateStart, dateEnd, actuality, changeDate, datePublish
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "CurrentVotes", in: managedObjectContext) else {
                fatalError("fatal error")
        }
        
        self.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        studyYear = try container.decode(String.self, forKey: .studyYear)
        voteNumber = try container.decode(String.self, forKey: .voteNumber)
        voteDescription = try container.decode(String.self, forKey: .voteDescription)
        dateStart = try container.decode(String.self, forKey: .dateStart)
        dateEnd = try container.decode(String.self, forKey: .dateEnd)
        actuality = try container.decode(String.self, forKey: .actuality)
        changeDate = try container.decode(String.self, forKey: .changeDate)
        datePublish = try container.decode(String.self, forKey: .datePublish)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(studyYear, forKey: .studyYear)
        try container.encode(voteNumber, forKey: .voteNumber)
        try container.encode(voteDescription, forKey: .voteDescription)
        try container.encode(dateStart, forKey: .dateStart)
        try container.encode(datePublish, forKey: .datePublish)
        try container.encode(dateEnd, forKey: .dateEnd)
        try container.encode(actuality, forKey: .actuality)
        try container.encode(changeDate, forKey: .changeDate)
    }
    
    
    
}
