//
//  DetailTVCellTableViewCell.swift
//  CampusClientIOS
//
//  Created by mac on 1/11/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class DetailTVCell: UITableViewCell {

    @IBOutlet weak var criteriousLabel: UILabel!
    
    @IBOutlet var markButtonOutletCollection: [MarkButton]!
    
    var criterionID: Int?
    
    weak var delegate: SaveOneCriterionMark?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func buttonsOutlet() {
        for i in 0..<markButtonOutletCollection.count {
            markButtonOutletCollection[i].markLabel.text = "\(i + 1)"
        }
    }
    
    func setBorders(number: Int) {
        for i in 0..<markButtonOutletCollection.count {
            if i == number {
                markButtonOutletCollection[i].border()
                delegate?.saveMark(id: criterionID!, mark: number + 1)
            } else {
                markButtonOutletCollection[i].removeBorder()
            }
        }
    }
    
    @IBAction func markButton1Action(_ sender: Any) {
        let number = 0
        setBorders(number: number)
    }
    
    @IBAction func markButton2Action(_ sender: Any) {
        let number = 1
        setBorders(number: number)
    }
    
    @IBAction func markButton3Action(_ sender: Any) {
        let number = 2
        setBorders(number: number)
    }
    
    @IBAction func markButton4Action(_ sender: Any) {
        let number = 3
        setBorders(number: number)
    }
    
    @IBAction func markButton5Action(_ sender: Any) {
        let number = 4
        setBorders(number: number)
    }
    
}

protocol SaveOneCriterionMark: class {
    func saveMark(id: Int, mark: Int)
}
