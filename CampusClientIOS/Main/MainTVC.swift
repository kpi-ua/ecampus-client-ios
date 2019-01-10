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
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.backgroundColor : UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.backgroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.accessibilityIgnoresInvertColors = false
    }
    
    func createExitAlert() {
        let alert = UIAlertController.init(title: "Ви впевнені?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) in
            let vcToPresent = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginScreenVC
            self.present(vcToPresent, animated: true, completion: {
                self.defaults.set(nil, forKey: "access_token")
            })
        }
        let cancelAction = UIAlertAction.init(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func actionForChosenCell(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "potochneSegue", sender: nil)
        default:
            createExitAlert()
        }
    }
    
}
