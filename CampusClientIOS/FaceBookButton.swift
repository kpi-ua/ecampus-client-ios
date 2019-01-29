//
//  FaceBookButton.swift
//  CampusClientIOS
//
//  Created by mac on 1/29/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

class FaceBookButton: UIButton {

    let buttonAnimationQ = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
    
    let buttonColor = UIColor.init(hexString: "#3C5A99")
    
    @IBOutlet weak var facebookLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    var view: UIView!
    var nibName = "FaceBookButton"
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib.init(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func setup() {
        view = loadFromNib()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        view.isUserInteractionEnabled = false
        view.backgroundColor = buttonColor
        facebookLabel.textColor = UIColor.white
        addSubview(view)
    }
    
    func buttonAnimation() {
        buttonAnimationQ.sync {
            UIView.animate(withDuration: 1, animations: {
                self.view.backgroundColor = UIColor.white
            }, completion: nil)
            UIView.animate(withDuration: 1, animations: {
                self.view.backgroundColor = self.buttonColor
            }, completion: nil)
        }
    }

}
