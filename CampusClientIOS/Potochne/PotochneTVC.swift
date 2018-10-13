//
//  PotochneTVC.swift
//  CampusClientIOS
//
//  Created by mac on 08.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit
import UIDropDown

class PotochneTVC: UITableViewController {
    
    @IBOutlet var potocneTV: UITableView!
    
    let prepodi: [String] = ["prepod0", "prepod1", "prepod2", "prepod3", "prepod4"]
    let cellIdentifier = "voteCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UITableView"
        potocneTV.dataSource = self
        potocneTV.delegate = self
        let nibName = UINib(nibName: "VoteTVCell", bundle: nil)
        potocneTV.register(nibName, forCellReuseIdentifier: cellIdentifier)
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prepodi.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = potocneTV.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VoteTVCell
        cell.nameOfPrepod(name: prepodi[indexPath.row])
        cell.addSubview(createDropMenu())
        return cell
    }
    
    func createDropMenu() -> UIDropDown {
        let drop = UIDropDown(frame: CGRect(x: 204, y: 5, width: 100, height: 30))
        //drop.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        drop.placeholder = "mark"
        drop.options = ["1", "2", "3", "4", "5"]
        drop.didSelect { (option, index) in
            print("You just select: \(option) at index: \(index)")
        }
        drop.hideOptionsWhenSelect = true
        return drop
    }
    
}
