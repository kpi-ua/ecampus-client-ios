//
//  EnterButton.swift
//  CampusClientIOS
//
//  Created by mac on 1/9/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class EnterButton: UIButton {

    @IBOutlet weak var buttonLabel: UILabel!
    
    let buttonAnimationQ = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    var view: RoundUIView!
    var nibName = "EnterButton"
    
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
        view.backgroundColor = themeColor
        buttonLabel.text = "Увійти"
        buttonLabel.textColor = UIColor.white
        view.cornerRadius = 0
        addSubview(view)
    }
    
    func buttonAnimation() {
        buttonAnimationQ.sync {
            UIView.animate(withDuration: 1, animations: {
                self.view.backgroundColor = UIColor.white
            }, completion: nil)
            UIView.animate(withDuration: 1, animations: {
                self.view.backgroundColor = themeColor
            }, completion: nil)
        }
    }

}
