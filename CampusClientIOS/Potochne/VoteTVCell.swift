//
//  VoteTVCell.swift
//  CampusClientIOS
//
//  Created by mac on 08.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit

class VoteTVCell: UITableViewCell {
    
    @IBOutlet weak var prepodNameLabel: UILabel!
    
    @IBOutlet weak var markLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func nameOfPrepod(name: String) {
        prepodNameLabel.text = name
    }
    
}
