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
    
    var passwordToPost: String?
    var loginToPost: String?
    
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
        //testRequest()
       /* if checkTextForNil() == true {
            testPost(loginPost: loginToPost!, passwordPost: passwordToPost!)
        }*/
        testPost(loginPost: "mky", passwordPost: "mky")
        UserDefaults.standard.set(loginTextField.text, forKey: loginKey)
        UserDefaults.standard.set(passwordTextField.text, forKey: passwordkey)
        performSegue(withIdentifier: "loginToMainSegue", sender: nil)
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
    
    func testRequest() {
        guard  let url = URL(string: "http://api.ecampus.kpi.ua/") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    func testPost(loginPost: String, passwordPost: String) {
        guard let url = URL(string: "http://api.ecampus.kpi.ua/oauth/token") else { return }
        let parametres = ["username": loginPost,
                          "password": passwordPost,
                          "grant_type": "password"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametres, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
        print("post done")
    }
    
}
