//
//  DataObjectProtocol.swift
//  CampusClientIOS
//
//  Created by Денис Ефремов on 4/8/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation
import CoreData

protocol DataObjectProtocol: class {
    func createObject<T: NSManagedObject>(entityName: String, object: T.Type)
}
