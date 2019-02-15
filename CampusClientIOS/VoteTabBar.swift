//
//  VoteTabBar.swift
//  CampusClientIOS
//
//  Created by mac on 2/15/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class VoteTabBar: UITabBarController {
    
    var currentVC: PotochneTVC?
    var archiveVC: studentArchiveVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self as? UITabBarControllerDelegate
        currentVC = PotochneTVC()
        archiveVC = studentArchiveVC()
        self.tabBar.backgroundColor = themeColor
        setImages()
        setControllers()
    }
    
    func setImages() {
        currentVC?.tabBarItem.image = UIImage.init(named: "icons8-todo_list")
        currentVC?.tabBarItem.selectedImage = UIImage.init(named: "icons8-todo_list_filled")
        archiveVC?.tabBarItem.image = UIImage.init(named: "icons8-book")
        archiveVC?.tabBarItem.selectedImage = UIImage.init(named: "icons8-book_filled")
    }
    
    func setControllers() {
        viewControllers = [currentVC, archiveVC] as? [UIViewController]
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    

}
