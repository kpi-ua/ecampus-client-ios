//
//  LogInVC.swift
//  CampusClientIOS
//
//  Created by mac on 10/27/18.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LogInVC: UIViewController {
    
    //key for userdefaults
    let loginKey = "login"
    
    //key for userdefaults
    let passwordkey = "password"
    
    var passwordToPost: String?
    var loginToPost: String?
    
    var accessToken: String?
    var tokenType: String?
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButtonStyle()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func enterButtonAction(_ sender: Any) {
        if checkTextForNil() == true {
            tokenRequest(loginPost: loginTextField.text!, passwordPost: passwordTextField.text!)
                if self.accessToken != nil {
                    print(self.accessToken)
                }
                if self.tokenType != nil {
                    print(self.tokenType)
                }
            UserDefaults.standard.set(loginTextField.text, forKey: loginKey)
            UserDefaults.standard.set(passwordTextField.text, forKey: passwordkey)
        } else {
            createErrorAlert()
        }
    }
    
    func checkTextForNil() ->Bool {
        loginToPost = loginTextField.text
        passwordToPost = passwordTextField.text
        
        if loginToPost != nil {
            return true
        }
        
        if passwordToPost != nil {
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
    
    func tokenRequest(loginPost: String, passwordPost: String) {
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parametres = ["password": passwordPost,
                          "username": loginPost,
                          "grant_type": "password"]
        
        request("http://api.ecampus.kpi.ua/oauth/token", method: .post, parameters: parametres, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            switch(response.result) {
            case.success(let data):
                print("success",data)
                if let data = response.result.value {
                    let JSON = data as! NSDictionary
                        if JSON["access_token"] != nil {
                            self.accessToken = JSON["access_token"] as? String
                            //print(self.accessToken)
                        }
                        if JSON["token_type"] != nil {
                            self.tokenType = JSON["token_type"] as? String
                            // print(self.tokenType)
                        }
                }
            case.failure(let error):
                print("Not Success",error)
            }
        }
    }
    
    func createErrorAlert() {
        let alert = UIAlertController.init(title: "Невірний логін або пароль", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func createActivity() -> ActivityIndicatorView{
        let activity = ActivityIndicatorView.init(title: "", center: self.view.center)
        return activity
    }
    
}

