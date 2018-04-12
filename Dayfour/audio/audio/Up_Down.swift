//
//  Up_Down.swift
//  audio
//
//  Created by Antonio Prado on 4/12/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class Up_Down: UIImageView {
    
    var referenceToController: ViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveLinear, animations: {
            
            if self.referenceToController!.isItOpen {
                self.referenceToController?.isItOpen = false
                self.referenceToController?.barView?.frame = CGRect(x: 0, y: kHeight-50, width: kWidth, height: 50)
                self.image = #imageLiteral(resourceName: "Up")
            } else {
                self.referenceToController?.isItOpen = true
                self.referenceToController?.barView?.frame = CGRect(x: 0, y: kHeight-200, width: kWidth, height: 200)
                self.image = #imageLiteral(resourceName: "Down")
            }
            
        }, completion: nil)
    }
    
}
