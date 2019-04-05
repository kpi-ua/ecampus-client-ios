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
    private let decoder = JSONDecoder.init()
    private let encoder = JSONEncoder.init()
    
    init() {
        
    }
    
    func createObject<T>(entityName: String, value: T, key: String) {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let newObj = NSManagedObject.init(entity: entity!, insertInto: context)
        do {
            
        } catch let err {
            
        }
        //newObj.setValue(convertedValue, forKey: key)
        do {
            try context.save()
            print("saved")
        } catch let error {
            print(error.localizedDescription)
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
    
    
    
    
    
}
