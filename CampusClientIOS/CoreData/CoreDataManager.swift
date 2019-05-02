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

class CoreDataManager {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context: NSManagedObjectContext?
    
    private typealias completion<T> = (T) -> Void
    
    init() {
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    public final func saveData(entity: CoreDataEntities, dataToSave: Any) {
        let settings = entity.settings()
        let entity = NSEntityDescription.entity(forEntityName: settings.entityName, in: context!)
        let objToSave = NSManagedObject.init(entity: entity!, insertInto: context!)
        objToSave.setValue(dataToSave, forKey: settings.attributeName)
        do {
            try context?.save()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    public final func fetchData<T>(entity: CoreDataEntities, type: T.Type) -> [T]? {
        let settings = entity.settings()
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: settings.entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context?.fetch(request) as! [T]
            return result
        } catch let err {
            print(err.localizedDescription)
        }
        return nil
    }
    
    public final func removeData(entity: CoreDataEntities) {
        let settings = entity.settings()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: settings.entityName)
        guard let result = try! context?.fetch(fetchRequest) else { return }
        for object in result {
            context?.delete(object as! NSManagedObject)
        }
    }
    
    public final func checkAndFetchData<T>(entity: CoreDataEntities, data: Any, type: T) -> [T]? {
        guard let result = fetchData(entity: entity, type: T.self) else { return nil }
        
        return nil
    }
}

