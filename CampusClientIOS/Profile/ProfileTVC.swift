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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
