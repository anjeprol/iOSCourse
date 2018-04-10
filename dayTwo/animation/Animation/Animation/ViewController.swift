//
//  ViewController.swift
//  Animation
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var box: UIView?
    var radians: CGFloat?
    var scale: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        box = UIView(frame: CGRect (x: 30, y:30, width: 50, height: 50))
        box?.backgroundColor = .purple
        view.addSubview(box!)
        
        radians = 180.0
        scale = 2
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: view)
        
        UIView.animate(withDuration: 1.5, animations: {
            self.box?.center = location
            let rotation = self.radians!*(CGFloat(Double.pi)/180)
            self.box?.transform = self.box!.transform.rotated(by: rotation)
            
            let scale = self.scale!
            self.box?.transform = self.box!.transform.scaledBy(x: scale, y: scale)
            
            if self.scale! == 2 {
                self.scale = 0.5
            } else {
                self.scale = 2
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

