//
//  ViewController.swift
//  Touches
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOfTouches: UILabel?
    var numberOfTaps: UILabel?
    var touchBegan: UILabel?
    var touchEnded: UILabel?
    var touchCancelled: UILabel?
    var touchMoved: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numberOfTouches = UILabel.custom(withFrame: CGRect(x:10, y:100, width: view.frame.width-20, height: 30), with: "# Touches" )
        view.addSubview(numberOfTouches!)
        numberOfTaps = UILabel.custom(withFrame: CGRect(x:10, y:140, width: view.frame.width-20, height: 30), with: "# Taps" )
        view.addSubview(numberOfTaps!)
        touchBegan = UILabel.custom(withFrame: CGRect(x:10, y:180, width: view.frame.width-20, height: 30), with: "T. Began" )
        view.addSubview(touchBegan!)
        touchMoved = UILabel.custom(withFrame: CGRect(x:10, y:220, width: view.frame.width-20, height: 30), with: "T. Moved" )
        view.addSubview(touchMoved!)
        touchEnded = UILabel.custom(withFrame: CGRect(x:10, y:260, width: view.frame.width-20, height: 30), with: "T Ended" )
        view.addSubview(touchEnded!)
        touchCancelled = UILabel.custom(withFrame: CGRect(x:10, y:300, width: view.frame.width-20, height: 30), with: "T Cancelled" )
        view.addSubview(touchCancelled!)
        
        view.isMultipleTouchEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberOfTouches?.text = "# Touches: \(touches.count)"
        
        // Sacando un touch arbitrariamente del conjunto
        let touch = touches.first!
        let position = touch.location(in: view)
        
        touchBegan?.text = "T. Began: x: \(position.x), y:\(position.y)"
        numberOfTaps?.text = "# Taps: \(touch.tapCount)"
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let position = touch.location(in: view)
        
        touchMoved?.text = "T. Moved: x: \(position), y: \(position.y)"
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let position = touch.location(in: view)
        
        touchEnded?.text = "T. Ended: x: \(position), y: \(position.y)"
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let position = touch.location(in: view)
        
        touchCancelled?.text = "T. Cancelled: x: \(position), y: \(position.y)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

