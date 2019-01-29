//
// Created by Andrew Gubskiy on 2019-01-28.
// Copyright (c) 2019 SINED. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiClient {
    
    static let shared = ApiClient(baseURL: Settings.apiEndpoint)
    
    private var token = ""
    private let baseURL: String
    private let decoder = JSONDecoder()
    
    // Initialization
    
    private init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    public func auth(login: String, password: String, completion: @escaping (String) -> Void) {
        let authURL = self.baseURL + "oauth/token"
        let headers = ["Content-Type": "application/x-www-form-urlencoded",
                       "Accept": "application/json"]
        
        let parameters = ["username": login,
                          "password": password,
                          "grant_type": "password"]
        
        request(authURL, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            switch (response.result) {
            case .success(let data):
                print(data)
                let json = data as! [String: AnyObject]
                if let token = json["access_token"] as? String {
                    self.token = token
                    mainQ.async {
                        completion(self.token)
                    }
                } else {
                    completion("")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func fbAuth(fbToken: String, completion: @escaping () -> Void) {
        let authUrl = self.baseURL + "Account/oauth/login/fb"
    }
    
    public func makeRequest(_ path: String,
                            method: HTTPMethod = .get,
                            parameters: Parameters? = nil,
                            _ closure: @escaping (Any) -> Void) {
        
        let headers = ["Authorization" : "Bearer " + self.token]
        let url = self.baseURL + path
        request(url, method: method, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
            .responseJSON { (response) in
                switch (response.result) {
                case .success(let data):
                    closure(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    
}

