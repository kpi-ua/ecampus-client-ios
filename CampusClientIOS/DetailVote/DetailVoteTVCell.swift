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
    var index: Int?
    let defaultColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    var viewController: DetailVoteTVC?
    
    func toReturnMark() -> Int {
        var mark: Int
        mark = self.mark
        return mark
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detalilVoteLabel.numberOfLines = 0
        detalilVoteLabel.frame = CGRect.init(x: 16, y: 11, width: 250, height: 80)
        detalilVoteLabel.sizeToFit()
    }
    
    @IBAction func markButtonPushed(_ sender: UIButton) {
        removeMarkButtonsStyle()
        makeButtonStyle(button: sender)
        self.mark = sender.tag + 1
        self.viewController?.getmark(mark: self.mark, index: self.index ?? 0)
    }
    
    private func makeButtonStyle(button: UIButton) {
        button.borderWidth = 1
        button.cornerRadius = 5
        button.borderColor = defaultColor
    }
    
    private func removeMarkButtonsStyle() {
        if let markButton = markButton {
            for i in 0..<markButton.count {
                self.markButton[i].borderWidth = 0
            }
        }
    }
    
}





