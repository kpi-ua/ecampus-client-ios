//
//  BorderedLabel.swift
//  CampusClientIOS
//
//  Created by Денис Ефремов on 4/4/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedLabel: UILabel {
    
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    @IBInspectable var borderColor: CGColor? {
        set { layer.borderColor = newValue }
        get { return layer.borderColor }
    }
    
}
