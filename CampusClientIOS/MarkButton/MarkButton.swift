//
//  MarkButton.swift
//  CampusClientIOS
//
//  Created by mac on 1/11/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class MarkButton: UIButton {

    @IBOutlet weak var markLabel: UILabel!
    
    private var view: RoundUIView!
    private var nibName = "MarkButton"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func loadFromNib() -> RoundUIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib.init(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! RoundUIView
        return view
    }
    
    public func setup() {
        view = loadFromNib()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.white
        markLabel.textColor = UIColor.ThemeColor.themeColor
        view.cornerRadius = 5
        addSubview(view)
    }
    
    func border() {
        self.view.borderWidth = 1
        self.view.borderColor = UIColor.ThemeColor.themeColor
    }
    
    func removeBorder() {
        self.view.borderWidth = 0
    }

}
