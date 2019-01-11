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
    
    var view: RoundUIView!
    var nibName = "MarkButton"
    
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
    
    func setup() {
        view = loadFromNib()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.white
        view.cornerRadius = 5
        addSubview(view)
    }

}
