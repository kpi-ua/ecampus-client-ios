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
    
    private var apiClient : ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
        super.init()
    }
    
    public func getAccountInfo(completion: @escaping (AccountInfoS) -> Void) {
        accountQ.async {
            self.apiClient.makeRequest("Account/Info", method: .get, parameters: nil, { (data) in
                let json = data as! [String : AnyObject]
                let info = self.parseAccountInfo(json: json)
                mainQ.async {
                    completion(info!)
                }
            })
        }
    }
    
    public func getAccountGroup() {
        accountQ.async {
            request("http://api.ecampus.kpi.ua/Account/student/group", method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: ["Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI00LoiLCJpZCI6IjU3NTI0IiwiaXNzIjoiaHR0cDovLzEyNy4wLjAuMSIsImF1ZCI6IjRiMjZkZGIyMDNkZDQxMzk4MjdiYTY5NzMyMjhjMGVhIiwiZXhwIjoxNTQ5MzcwNzkzLCJuYmYiOjE1NDkyODQzOTN9.fOWMEyj4f_gIlX4pAz4XIovR6YVHgi8UUNQ-YI7IUZc"]).responseJSON { (response) in
                switch (response.result) {
                case .success(let data):
                    print(data)
                    let json = data as! [[String : Any]]
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let groupData = try decoder.decode(AcountGroupSingle.self, from: data)
                        print(groupData)
                    } catch let err {
                        print("Err", err)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    struct AcountGroupArray: Codable {
        var AcountGroupSingle: [AcountGroupSingle]
    }
    
    struct AcountGroupSingle: Codable {
        var studyGroupId: String?
        var studyGroupName: String?
        var studyCourse: String?
        var dcStudyGroupId: String?
        var proftraintotalId: String?
        var proftrain: String?
        var totalShifr: String?
        var okrId: String?
        var okr: String?
        var cathedraId: String?
        var cathedra: String?
        var dcStudyFormId: String?
        var studyformname: String?
        var yearIntake: String?
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

