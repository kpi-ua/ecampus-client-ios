//
//  TermsVC.swift
//  CampusClientIOS
//
//  Created by mac on 10/29/18.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit

class TermsVC: UIViewController {
    
    @IBOutlet weak var termsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsTextView.text = "terms should be here"
        termsTextView.isEditable = false
    }
    
    @IBAction func hideButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
