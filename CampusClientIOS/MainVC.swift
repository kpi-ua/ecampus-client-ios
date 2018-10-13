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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(createDropMenu())
    }
    
    func createDropMenu() -> UIDropDown {
        let drop = UIDropDown(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        drop.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        drop.placeholder = "mark"
        drop.options = ["1", "2", "3", "4", "5"]
        drop.didSelect { (option, index) in
            print("You just select: \(option) at index: \(index)")
        }
        //drop.addConstraint(<#T##constraint: NSLayoutConstraint##NSLayoutConstraint#>)
        drop.hideOptionsWhenSelect = true
        return drop
    }
    
    
}
