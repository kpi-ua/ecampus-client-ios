//
//  VoteNavController.swift
//  CampusClientIOS
//
//  Created by mac on 11/29/18.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit

class VoteNavController: UINavigationController {

    let navColor = UIColor.init(hexString: "#0277bd")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = navColor
        navigationController?.navigationBar.barTintColor = navColor
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
}
