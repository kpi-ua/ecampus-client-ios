//
//  UpdatedDecoder.swift
//  CampusClientIOS
//
//  Created by mac on 2/4/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation
import SwiftyJSON

class UpdatedDecoder: NSObject {
    
    private var data: Any?
    private var type: Type?
    
    lazy var structType: Type = {
        return type!
    }()
    
    init(data: Any?, type: Type?) {
        self.data = data
        self.type = type
    }
    
    private func checkForArray(data: Any) {
        
        if data is [[String : Any]] {
            
        }
        if data is [String : Any] {
            
        }
    }
    
    private func decodeArray(data: Any, type: Type) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let decoder = JSONDecoder()
            let decoded = try! decoder.decode(Array<type>, from: jsonData)
        } catch let err {
            print("Err", err)
        }
    }
    
    private func decodeSibgleObject() {
        
    }
    
}
