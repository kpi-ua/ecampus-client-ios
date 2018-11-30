//
//  RequestClass.swift
//  
//
//  Created by mac on 11/30/18.
//

import Foundation
import Alamofire
import SwiftyJSON

class RequestClass: NSObject {
    
    let accessToken = UserDefaults.standard.string(forKey: "access_token")
    
    func termsRequest() {
        let url = "http://api.ecampus.kpi.ua/Vote/Terms"
        let auth = ["Authorization" : "Bearer " + accessToken!]
        request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: auth).responseJSON { (response) in
            switch(response.result) {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
