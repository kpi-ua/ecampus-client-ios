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
    var englishName: String?
    var editingProfile = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Мій профіль"
        setHeaders()
        makeRequests()
        hideKeyboardWhenTappedAround()
    }
    
    func setHeaders() {
        firstHeaderCell.backgroundColor = UIColor.ThemeColor.themeColor
        secondHeaderCell.backgroundColor = UIColor.ThemeColor.themeColor
        firstHeaderLabel.textColor = UIColor.white
        secondHeaderLabel.textColor = UIColor.white
    }
    
    func makeRequests() {
        profileQ.sync {
            self.accountInfoReq.getAccountInfo { (info) in
                self.info = info
                self.setLabels()
                self.accountInfoReq.getEnglishName(userID: String(self.info!.id), completion: { (data) in
                    self.englishName = data as? String
                })
            }
            self.accountInfoReq.getAccountGroup { (group) in
                self.groupInfo = group
                print("getGroupInfo")
            }
        }
    }
    
    func setLabels() {
        nameLabel.text = info?.name
        subdivisionLabel.text = info?.subdivision[0].name
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
    
    @objc func createSaveAlert(_ sender: UIBarButtonItem) {
        editingProfile = false
        let alert = UIAlertController.init(title: "Ви впевнені, що хочете зберегти зміни?", message: nil, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
            //Code for saving changes in profile
            self.editingProfile = false
            self.resetEditButtonStyle()
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
            //Actions after cancelling editing
            self.editingProfile = false
            self.resetEditButtonStyle()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func resetEditButtonStyle() {
        let buttonItem = UIBarButtonItem.init(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editButton(_:)))
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    @IBAction func editButton(_ sender: Any) {
        print("editing")
        print(englishName)
        editingProfile = true
        let barButoon = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(createSaveAlert(_:)))
        self.navigationItem.rightBarButtonItem = barButoon
        print(editingProfile)
        tableView.reloadData()
        print("reloaded")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            return setEnglishNameRow()
        default:
            return setHeight(index: indexPath)
        }
    }
    
    func setEnglishNameRow() -> CGFloat {
        if editingProfile == false && englishName == "" {
            return 80
        }
        if editingProfile && englishName != "" {
            return 120
        }
        if englishName == "" {
            return 40
        }
        return 40
    }
    
    func setHeight(index: IndexPath) -> CGFloat {
        switch index.row {
        case 0:
            return 29.5
        case 3:
            return 29.5
        default:
            return 80
        }
    }
    
}
