//
//  ProfileTVC.swift
//  CampusClientIOS
//
//  Created by mac on 1/29/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subdivisionLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var marksLabel: UILabel!
    @IBOutlet weak var studyFormLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speciltyLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var firstHeaderCell: UIView!
    @IBOutlet weak var secondHeaderCell: UITableViewCell!
    @IBOutlet weak var firstHeaderLabel: UILabel!
    @IBOutlet weak var secondHeaderLabel: UILabel!
    
    let profileQ = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
    let accountInfoReq = AccountInfo.init(apiClient: ApiClient.shared)
    var info: AccountInfoS?
    var groupInfo: [AcountGroup]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Мій профіль"
        firstHeaderCell.backgroundColor = themeColor
        secondHeaderCell.backgroundColor = themeColor
        firstHeaderLabel.textColor = UIColor.white
        secondHeaderLabel.textColor = UIColor.white
        makeRequests()
    }
    
    func makeRequests() {
        profileQ.sync {
            accountInfoReq.getAccountInfo { (info) in
                self.info = info
                self.setLabels()
                self.accountInfoReq.getEnglishName(userID: String(self.info!.id), completion: { (data) in
                    self.checkForEnglishName(data: data as! String)
                })
            }
            accountInfoReq.getAccountGroup { (group) in
                self.groupInfo = group
                self.setLabels()
            }
        }
    }
    
    func setLabels() {
        nameLabel.text = info?.name
        subdivisionLabel.text = groupInfo?[0].cathedra
        groupLabel.text = groupInfo?[0].studyGroupName
        studyFormLabel.text = groupInfo?[0].studyformname
        courseLabel.text = groupInfo?[0].studyCourse
        speciltyLabel.text = groupInfo?[0].proftrain
        tableView.reloadData()
    }
    
    private func createEnglishNameLabel(text: String) -> UILabel {
        let rect = CGRect.init(x: 16, y: 48, width: 343, height: 21)
        let label = UILabel.init(frame: rect)
        return label
    }
    
    private func createEnglishNameTextField() -> UITextField {
        let rect = CGRect.init(x: 16, y: 48, width: 343, height: 21)
        let textField = UITextField.init(frame: rect)
        return textField
    }
    
    func checkForEnglishName(data: String) {
        if data == "" {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func createSaveAlert() {
        let alert = UIAlertController.init(title: "Ви впевнені, що хочете зберегти зміни?", message: nil, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
            //Code for saving changes in profile
            self.resetEditButtonStyle()
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
            //Actions after cancelling editing
            self.resetEditButtonStyle()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
    }
    
    func resetEditButtonStyle() {
        let buttonItem = UIBarButtonItem.init(title: "Edit", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    @IBAction func editButton(_ sender: Any) {
        let buttonItem = UIBarButtonItem.init(title: "Save", style: .plain, target: nil, action: #selector(self.createSaveAlert))
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    
}
