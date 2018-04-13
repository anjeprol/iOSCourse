//
//  Extensions.swift
//  Contacts
//
//  Created by Antonio Prado on 4/13/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import Foundation
import UIKit

enum Colors {
    case Purple
    case Red
    case Yellow
    
    func getColor() -> UIColor {
        switch self {
            case .Purple: return .purple
            case .Red: return .red
            case .Yellow: return .yellow
        }
    }
}

extension UITextField {
    class func custom(originY: Double, placeholder: String, delegate: UITextFieldDelegate) -> UITextField {
        let tf = UITextField(frame: CGRect(x:15, y:originY, width: Double(UIScreen.main.bounds.width-30), height:30.0))
        tf.placeholder = placeholder
        tf.delegate = delegate
        tf.textColor = Colors.Purple.getColor()
        tf.returnKeyType = .next
        tf.keyboardAppearance = .dark
        tf.borderStyle = .roundedRect
        
        return tf
    }
    
}

extension UIButton {
    class func custom(rect: CGRect, title: String) -> UIButton {
        let buttom = UIButton(frame: rect)
        buttom.setTitle(title, for: .normal)
        buttom.setTitleColor(Colors.Purple.getColor(), for: .normal)
        
        return buttom
    }
}
