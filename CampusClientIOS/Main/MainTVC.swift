//
//  MainTVC.swift
//  CampusClientIOS
//
//  Created by mac on 10/28/18.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainTVC: UITableViewController {

    var password: String?
    var login: String?
    let mainMenu = ["Голосування", "Розклад", "Вийти"]
    var status: String?
    var potochneSections = [VoteTerms]()
    var prepodsToVote = [PrepodToVote]()
    let navColor = UIColor.init(hexString: "#0277bd")
    
    override func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSettings()
        checkForStatus()
        getCurrentVote()
        requesForPrepods()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTVCell
        cell.infoLabel.text = mainMenu[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationThroughMenu(index: indexPath)
    }
    
    func navigationThroughMenu(index: IndexPath) {
        switch index.row {
        case 0:
            performSegue(withIdentifier: "voteSegue", sender: nil)
        case 1:
            print("")
        default:
            exitCellTapped()
        }
    }
    
    func exitCellTapped() {
        createExitAlert()
    }
    
    func createExitAlert() {
        let alert = UIAlertController.init(title: "Ви впевнені?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) in
            UserDefaults.standard.set(nil, forKey: "access_token")
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LogInVC
            self.present(loginVC, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "voteSegue" {
            let destinationVC: UITabBarController = segue.destination as! VoteTabBarController
            let potochneVC = destinationVC.viewControllers![0] as! PotochneTVC
            potochneVC.sections = potochneSections
            potochneVC.prepodi = prepodsToVote
        }
    }
    
    func checkForStatus() {
        let urlAccountInfo = "http://api.ecampus.kpi.ua/Account/Info"
        let token = UserDefaults.standard.string(forKey: "access_token")
        let auth = ["Authorization" : "Bearer " + token!]
        request(urlAccountInfo, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: auth as HTTPHeaders).responseJSON { (response) in
            switch(response.result){
            case .success(let data):
                let json = data as! [String : AnyObject]
                let position = json["position"] as! [AnyObject]
                self.status = position[0]["name"] as? String
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCurrentVote() {
        let currentVoteUrl = "http://api.ecampus.kpi.ua/Vote/term/current"
        let token = UserDefaults.standard.string(forKey: "access_token")
        let auth = ["Authorization" : "Bearer " + token!]
        request(currentVoteUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: auth).responseJSON { (response) in
            switch(response.result) {
            case .success(let data):
                let json = data as! [[String : AnyObject]]
                self.parseVote(json: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func parseVote(json: [[String: AnyObject]]) {
        for i in 0..<json.count {
            guard let key = json[i]["id"] else { return }
            guard let start = json[i]["studyPeriod"]?["start"] else { return }
            guard let end = json[i]["studyPeriod"]?["end"] else { return }
            guard let semester = json[i]["semester"] else { return }
            guard let vote = json[i]["voteNumber"] else { return }
            let studyTerms = StudyTerms.init(start: String.init(describing: start!), end: String.init(describing: end!))
            let voteElement = VoteTerms.init(studyTerm: studyTerms, semester: String.init(describing: semester), voteNumber: String.init(describing: vote), id: String.init(describing: key))
            self.potochneSections.append(voteElement)
        }
    }
    
    func requesForPrepods() {
        let url = "http://api.ecampus.kpi.ua/Vote/Persons"
        let token = UserDefaults.standard.string(forKey: "access_token")
        let auth = ["Authorization" : "Bearer " + token!]
        request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: auth).responseJSON { (response) in
            switch (response.result) {
            case .success(let data):
                let json = data as! [[String: AnyObject]]
                self.parsePrepods(json: json)
                print(self.prepodsToVote)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func parsePrepods(json: [[String: AnyObject]]) {
        for i in 0..<json.count {
            guard let id = json[i]["employeesId"] else { return }
            guard let lecturer = json[i]["lecturer"] else { return }
            let prepod = PrepodToVote.init(employeesId: (id as! String), lecturer: (lecturer as! String))
            self.prepodsToVote.append(prepod)
        }
    }
    
    func navigationBarSettings() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = navColor
        self.navigationController?.navigationBar.barTintColor = navColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.accessibilityIgnoresInvertColors = false
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.backgroundColor : UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.backgroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.accessibilityIgnoresInvertColors = false
    }
    
    
}



