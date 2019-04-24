//
//  CoreDataManager.swift
//  CampusClientIOS
//
//  Created by Денис Ефремов on 4/5/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum DataFetch {
    
    case CurrentVote

    func settings() -> FetchSettings? {
        switch self {
        case .CurrentVote:
            return FetchSettings.init(entityName: "CurrentVotes", entity: CurrentVotes.self)
        default:
            return nil
        }
    }
}

struct FetchSettings {
    var entityName: String
    
    
    init<T>(entityName: String, entity: T) {
        self.entityName = entityName
        
    }
    
}

class CoreDataManager {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context: NSManagedObjectContext?
    
    init() {
        self.context = appDelegate.persistentContainer.viewContext
    }
    
//    func saveData() {
//        do {
//            try context?.save()
//            print("saved")
//        } catch let err {
//            print(err.localizedDescription)
//        }
//    }
    
//    func fetchData(entityName: String) {
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(request)
//            print(result)
//        } catch let err {
//            print(err.localizedDescription)
//        }
//    }
    
    public final func saveData(entityName: String, attributeName: String, dataToSave: Any) {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context!)
        let objToSave = NSManagedObject.init(entity: entity!, insertInto: context!)
        objToSave.setValue(dataToSave, forKey: attributeName)
        do {
            try context?.save()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    public final func fetchData<T>(entity: DataFetch) -> [T]? {
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context?.fetch(request) as! [T]
            return result
        } catch let err {
            print(err.localizedDescription)
        }
        return nil
    }
    
}
