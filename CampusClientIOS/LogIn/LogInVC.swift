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
    
    let defaultLogin = "1111"
    let defaultPassword = "1111"
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var enterButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = nil
        enterButtonStyle()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func enterButtonAction(_ sender: Any) {
        if checkTextForNil() == false {
            infoLabel.text = "please, enter all data"
        }
        if checkIfCorrect() == false {
            infoLabel.text = "uncorrect login or password"
        }
        else {
            UserDefaults.standard.set(loginTextField.text, forKey: loginKey)
            UserDefaults.standard.set(passwordTextField.text, forKey: passwordkey)
            performSegue(withIdentifier: "loginToMainSegue", sender: nil)
        }
        
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
    
    func checkIfCorrect() -> Bool {
        if loginTextField.text == self.defaultLogin && passwordTextField.text == self.defaultPassword {
            return true
        }
        return false
    }
    
    func enterButtonStyle() {
        enterButtonOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
        enterButtonOutlet.borderWidth = 1
        enterButtonOutlet.cornerRadius = 20
        enterButtonOutlet.borderColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        enterButtonOutlet.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    }
    
}
