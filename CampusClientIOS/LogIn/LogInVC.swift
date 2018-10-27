//
//  LogInVC.swift
//  CampusClientIOS
//
//  Created by mac on 10/27/18.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    //key for userdefaults
    let loginKey = "login"
    
    //key for userdefaults
    let passwordkey = "password"
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = nil
    }
    
    @IBAction func enterButtonAction(_ sender: Any) {
        if checkTextForNil() == false {
            infoLabel.text = "please, enter all data"
            
        }
        UserDefaults.standard.set(loginTextField.text, forKey: loginKey)
        UserDefaults.standard.set(passwordTextField.text, forKey: passwordkey)
    }
    
    func checkTextForNil() ->Bool {
        if loginTextField.text == "" {
            return false
        }
        if passwordTextField.text == "" {
            return false
        }
        return true
    }
    
}
