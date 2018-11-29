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
import SKActivityIndicatorView

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
            UserDefaults.standard.set(loginTextField.text, forKey: "login")
            UserDefaults.standard.set(passwordTextField.text, forKey: "password")
            tokenRequest(loginPost: loginTextField.text!, passwordPost: passwordTextField.text!)
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
        let navColor = UIColor.init(hexString: "#0277bd")
        enterButtonOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
        enterButtonOutlet.borderWidth = 1
        enterButtonOutlet.cornerRadius = 20
        enterButtonOutlet.borderColor = navColor
        enterButtonOutlet.backgroundColor = navColor
    }
    
    func tokenRequest(loginPost: String, passwordPost: String) {
        SKActivityIndicator.show("Loading", userInteractionStatus: false)
        let headers = [ "Content-Type": "application/x-www-form-urlencoded" ]
        let parameters = ["password": passwordPost,
                          "username": loginPost,
                          "grant_type": "password"]
        request("http://api.ecampus.kpi.ua/oauth/token", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            switch(response.result) {
            case.success(let data):
                print("success",data)
                if let data = response.result.value {
                    let JSON = data as! NSDictionary
                    SKActivityIndicator.dismiss()
                    print("data")
                    if JSON["access_token"] != nil {
                        self.goToMain(token: JSON["access_token"] as? String)
                        UserDefaults.standard.set(JSON["access_token"] as? String, forKey: "access_token")
                    } else {
                        self.createErrorAlert()
                    }
                }
            case.failure(let error):
                SKActivityIndicator.dismiss()
                print("Not Success",error)
                self.createErrorAlert()
            }
        }
    }
    
    func createErrorAlert() {
        let alert = UIAlertController.init(title: "Невірний логін або пароль", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToMain(token: String?) {
        if token != nil {
            performSegue(withIdentifier: "loginToMainSegue", sender: nil)
        } else {
            createErrorAlert()
        }
    }
    
}

