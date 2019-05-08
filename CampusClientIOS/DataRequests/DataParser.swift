//
//  DataParser.swift
//  CampusClientIOS
//
//  Created by mac on 4/30/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataParser {
    
    private let decoder = JSONDecoder.init()
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private let persistentContainer: NSPersistentContainer?
    private let context: NSManagedObjectContext?
    
    init() {
        self.persistentContainer = appDelegate?.persistentContainer
        self.context = self.persistentContainer?.viewContext
    }
    
    public final func convertToJSONArray(moArray: [NSManagedObject]) -> Any {
        var jsonArray: [[String: Any]] = []
        for item in moArray {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
    
    public final func parseData<T: Codable>(data: Any, type: T.Type) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = context
            return try decoder.decode(type, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
}
