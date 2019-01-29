//
//  AppDelegate.swift
//  CampusClientIOS
//
//  Created by mac on 07.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let themeColor = UIColor.init(hexString: "#208843")

let mainQ = DispatchQueue.main

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //chooseController()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /*func chooseController(completion: @escaping () -> Void) {
        let token = UserDefaults.standard.string(forKey: "access_token")
        let login = UserDefaults.standard.string(forKey: "login")
        let password = UserDefaults.standard.string(forKey: "password")
        if token != nil {
            SKActivityIndicator.show()
            requestData.tokenRequest(loginPost: login!, passwordPost: password!) { (token) in
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainVC = storyboard.instantiateViewController(withIdentifier: "mainNavVC") as! UINavigationController
                self.window?.rootViewController = mainVC
                SKActivityIndicator.dismiss()
            }
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as!LogInVC
            self.window?.rootViewController = loginVC
        }
    }
    
    func chooseController() {
        let token = UserDefaults.standard.string(forKey: "access_token")
        let login = UserDefaults.standard.string(forKey: "login")
        let password = UserDefaults.standard.string(forKey: "password")
        if password == nil || login == nil || token == nil {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as!LogInVC
            self.window?.rootViewController = loginVC
        } else {
            tokenRequest(loginPost: login!, passwordPost: password!)
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "mainNavVC") as! UINavigationController
            self.window?.rootViewController = mainVC
        }
    }
    
    @objc func tokenRequest(loginPost: String, passwordPost: String) {
        let headers = [ "Content-Type": "application/x-www-form-urlencoded" ]
        let parameters = ["password": passwordPost,
                          "username": loginPost,
                          "grant_type": "password"]
            request(Settings.apiEndpoint + "oauth/token", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
                switch(response.result) {
                case.success(let data):
                    print("success",data)
                    if let data = response.result.value {
                        let JSON = data as! NSDictionary
                        if JSON["access_token"] != nil {
                            UserDefaults.standard.set(JSON["access_token"] as? String, forKey: "access_token")
                        } else {
                        }
                    }
                case.failure(let error):
                    print("Not Success",error)
                }
            }
    }*/
    
}

