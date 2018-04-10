//
//  Extensions.swift
//  Touches
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    class func custom(withFrame: CGRect, with withText: String) -> UILabel {
        let label = UILabel (frame: withFrame)
        label.textColor = .purple
        label.font = UIFont(name:"", size:16)
        label.adjustsFontSizeToFitWidth = true
        label.text = withText
        return label
    }
}
