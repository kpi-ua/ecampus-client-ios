//
//  DetailVoteTVCell.swift
//  CampusClientIOS
//
//  Created by mac on 17.10.2018.
//  Copyright © 2018 SINED. All rights reserved.
//

import UIKit

class DetailVoteTVCell: UITableViewCell {
    
    @IBOutlet weak var detalilVoteLabel: UILabel!
    
    @IBOutlet var markButton: [UIButton]!
    
    var mark = 0
    let defaultColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detalilVoteLabel.numberOfLines = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func markButtonPushed(_ sender: UIButton) {
        removeMarkButtonsStyle()
        makeButtonStyle(button: sender)
        mark = sender.tag + 1
        print(mark)
    }
    
    func makeButtonStyle(button: UIButton) {
        button.borderWidth = 1
        button.cornerRadius = 5
        button.borderColor = defaultColor
    }
    
    func removeMarkButtonsStyle() {
        if let markButton = markButton {
            for i in 0..<markButton.count {
                self.markButton[i].borderWidth = 0
            }
        }
    }
        
}
