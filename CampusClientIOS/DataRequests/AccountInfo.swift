//
//  AccountInfo.swift
//  CampusClientIOS
//
//  Created by mac on 1/14/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AccountInfo: NSObject {
    
    private let accountQ = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
    
    private let decoder = JSONDecoder()
    
    private var apiClient : ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
        super.init()
    }
    
    public func getAccountInfo(completion: @escaping (AccountInfoS) -> Void) {
        accountQ.async {
            self.apiClient.makeRequest("Account/Info", method: .get, parameters: nil, { (data) in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let info = try self.decoder.decode(AccountInfoS.self, from: jsonData)
                    mainQ.async {
                        print(info)
                        completion(info)
                    }
                } catch let err {
                    print("Err", err)
                }
            })
        }
    }
    
    public func getAccountGroup(completion: @escaping ([AcountGroup]) -> Void) {
        accountQ.async {
            self.apiClient.makeRequest("Account/student/group", { (data) in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let groupData = try self.decoder.decode(Array<AcountGroup>.self, from: jsonData)
                    mainQ.async {
                        completion(groupData)
                        print(groupData)
                    }
                } catch let err {
                    print("Err", err)
                }
            })
        }
    }
    
    public func getEnglishName(userID: String, completion: @escaping (Any) -> Void) {
        accountQ.async {
            self.apiClient.makeRequest("/Account/\(userID)/Name/Eng", { (data) in
                completion(data)
            })
        }
    }
    
    
    
}

