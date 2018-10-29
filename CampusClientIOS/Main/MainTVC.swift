//
//  MainTVC.swift
//  CampusClientIOS
//
//  Created by mac on 10/28/18.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController {

    var password: String?
    var login: String?
    let mainMenu = ["Голосування", "Розклад", "Вийти"]
    
    override func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
            performSegue(withIdentifier: "tableSegue", sender: nil)
        default:
            exitCellTapped()
        }
    }
    
    func exitCellTapped() {
        UserDefaults.standard.set(nil, forKey: "login")
        UserDefaults.standard.set(nil, forKey: "password")
        createExitAlert()
    }
    
    func createExitAlert() {
        let alert = UIAlertController.init(title: "Ви впевнені?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) in
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LogInVC
            self.present(loginVC, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}
