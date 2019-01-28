//
//  MainTVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/10/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController {
    
    let menuItems = ["Поточне", "Вихід"]
    let defaults = UserDefaults.standard
    let accountInfo = AccountInfo.init()
    
    let studentStatus = "студент"
    let prepodStatus = "викладач"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Головне меню"
        navigationBarSettings()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        cell.textLabel!.text = menuItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        actionForChosenCell(indexPath: indexPath)
    }
    
    func navigationBarSettings() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = themeColor
        self.navigationController?.navigationBar.barTintColor = themeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.accessibilityIgnoresInvertColors = false
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.backgroundColor : UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.backgroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.accessibilityIgnoresInvertColors = false
    }
    
    func createExitAlert() {
        let alert = UIAlertController.init(title: "Ви впевнені?", message: nil, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
            let vcToPresent = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginScreenVC
            self.present(vcToPresent, animated: true, completion: {
                self.defaults.set(nil, forKey: "access_token")
            })
        }
        let cancelAction = UIAlertAction.init(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func actionForChosenCell(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            requestStatus()
        default:
            createExitAlert()
        }
    }
    
    //check is user student of teacher
    func requestStatus() {
        accountInfo.getAccountInfo { (info) -> Void in
            guard let status = info.position?.name else { return }
            print(status)
            self.presentControllerDependsOnStatus(status: self.checkForStatus(status: status))
        }
    }
    
    func checkForStatus(status: String) -> String {
        if status.lowercased().contains(studentStatus) {
            return studentStatus
        }
        if status.lowercased().contains(prepodStatus) {
            return prepodStatus
        }
        return "error"
    }
    
    func presentControllerDependsOnStatus(status: String) {
        switch status {
        case studentStatus:
            performSegue(withIdentifier: "potochneStudentSegue", sender: nil)
        case prepodStatus :
            performSegue(withIdentifier: "potochneStudentSegue", sender: nil)
        default:
            createErrorAlert()
        }
    }
    
    func createErrorAlert() {
        let alert = UIAlertController.init(title: "Помилка", message: nil, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
