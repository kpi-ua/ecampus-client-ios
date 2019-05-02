//
//  DataParser.swift
//  CampusClientIOS
//
//  Created by mac on 4/30/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation

class DataParser {
    
    private let decoder = JSONDecoder.init()
    
    init() { }
    
    public final func parseData<T: Codable>(data: Any, type: T.Type) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            let result = try self.decoder.decode(type, from: jsonData)
            return result
        } catch let err {
            print(err.localizedDescription)
        }
        return nil
    }
    
}
