//
//  CellTouch.swift
//  CampusClientIOS
//
//  Created by mac on 3/28/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation

class CellTouch {
    
    public var indexPath: IndexPath?
    public var isSelected: Bool?
    
    init(indexPath: IndexPath, isSelected: Bool) {
        self.isSelected = isSelected
        self.indexPath = indexPath
    }
    
    init() {
        
    }
}
