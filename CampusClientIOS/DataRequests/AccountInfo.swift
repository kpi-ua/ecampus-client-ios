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
    
    let accountQ = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
    
    public func getAccountInfo(completion: @escaping (AccountInfoS) -> Void) {
        let url = Settings.apiEndpoint + "Account/Info"
        guard let token = UserDefaults.standard.object(forKey: "access_token") as? String else { return }
        let auth = ["Authorization" : "Bearer " + token]
        accountQ.async {
            request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: auth).responseJSON(completionHandler: { (response) in
                switch(response.result) {
                case .success(let data):
                    let json = data as! [String : AnyObject]
                    let info = self.parseAccountInfo(json: json)
                    mainQ.async {
                        completion(info!)
                    }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    private func parseAccountInfo(json: [String : AnyObject]) -> AccountInfoS? {
        guard let positionAc = json["position"] as? [[String : AnyObject]] else { return nil }
        guard let posID = positionAc[0]["id"] else { return nil }
        guard let posName = positionAc[0]["name"] else { return nil }
        guard let subdivisionAc = json["subdivision"] as? [[String : AnyObject]] else { return nil }
        guard let subId = subdivisionAc[0]["id"] else { return nil }
        guard let subName = subdivisionAc[0]["name"] else { return nil }
        guard let moder = json["isBulletinBoardModerator"] else { return nil }
        guard let sid = json["sid"] else { return nil }
        guard let name = json["name"] else { return nil }
        guard let id = json["id"] else { return nil }
        let pos = Position.init(name: posName as? String, id: posID as? String)
        let subd = Subdivision.init(name: subName as? String, id: subId as? String)
        let acInf = AccountInfoS.init(position: pos, subdivision: subd, isBulletinBoardModerator: moder as? String, sid: sid as? String, name: name as? String, id: id as? String)
        return acInf
    }
    
}

struct AccountInfoS: Encodable {
    var position: Position?
    var subdivision: Subdivision?
    var isBulletinBoardModerator: String?
    var sid: String?
    var name: String?
    var id: String?
}

struct Position: Encodable {
    var name: String?
    var id: String?
}

struct Subdivision: Encodable {
    var name: String?
    var id: String?
}
