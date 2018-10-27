//
//  MainVC.swift
//  CampusClientIOS
//
//  Created by mac on 07.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit
import UIDropDown

class MainVC: UIViewController {
    
    var password: String?
    var login: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func checkForLogin() -> Bool {
        if self.login == nil {
            return false
        }
        if self.password == nil {
            return false
        }
        else {
            return true
        }
    }
    
   
    
    
}
