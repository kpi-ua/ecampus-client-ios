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
    
    init() {
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func saveData() {
        do {
            try context?.save()
            print("saved")
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func fetchData(entityName: String) {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print(result)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func createObject(entityName: String) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.context!)
        let newObject = NSManagedObject.init(entity: entity!, insertInto: context)
        return newObject
    }
    
    
}
