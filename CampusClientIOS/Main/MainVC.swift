//
//  MainVC.swift
//  CampusClientIOS
//
//  Created by mac on 07.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit
import UIDropDown

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var password: String?
    var login: String?
    let mainMenu = ["Голосування", "Розклад", "Вийти"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTVCell
        cell.menuItemLabel.text = mainMenu[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LogInVC
        present(loginVC, animated: true, completion: nil)
    }
    
}
