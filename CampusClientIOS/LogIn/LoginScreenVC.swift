//
//  LoginScreenVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/9/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class LoginScreenVC: UIViewController {
    
    @IBOutlet weak var enterButtonOutlet: EnterButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let dataRequest = VoteRequest.init(apiClient: ApiClient.shared)
    let apiClient = ApiClient.shared
    

    let defaults = UserDefaults.standard
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButtonOutlet.setup()
        hideKeyboardWhenTappedAround()
    }
   
    func checkLoginText() -> Bool {
        if loginTextField.text == "" {
            return true
        } else {
            return false
        }
    }
    
    func checkPasswordText() -> Bool {
        if passwordTextField.text == "" {
            return true
        } else {
            return false
        }
    }
    
    func checkToken(token: String) -> Bool {
        if token == "" {
            return true
        }
        return false
    }
    
    func detectLoginError() -> Bool {
        if checkLoginText() {
            createAuthAllert(message: "Уведіть логін")
            return true
        }
        if checkPasswordText() {
            createAuthAllert(message: "Уведіть пароль")
            return true
        }
        return false
    }
    
    func createAuthAllert(message: String) {
        let alert = UIAlertController.init(title: "Помилка", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true) {
            self.passwordTextField.text = nil
        }
    }
    
    @IBAction func enterButton(_ sender: Any) {
        enterButtonOutlet.buttonAnimation()
        if detectLoginError() {
            return
        }
        let center = CGPoint.init(x: self.view.frame.height, y: self.view.frame.height)
        let activityIndicator = ActivityIndicatorView.init(title: "", center: center)
        activityIndicator.startAnimating()
        self.apiClient.auth(login: loginTextField.text!, password: passwordTextField.text!) { (token) -> Void in
            print(token)
            if self.checkToken(token: token) {
                self.createAuthAllert(message: "Невірний логін або пароль")
                activityIndicator.stopAnimating()
            } else {
                self.defaults.set(token, forKey: "access_token")
                activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "loginToMainSegue", sender: nil)
            }
        }
    }
    
    
    
}

