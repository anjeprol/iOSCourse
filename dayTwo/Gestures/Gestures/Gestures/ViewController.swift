//
//  ViewController.swift
//  Gestures
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var container: UIImageView?
    
    // Gestures
    var panGesture: UIGestureRecognizer?
    var pinchGesture: UIPinchGestureRecognizer?
    var rotationGesture: UIRotationGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height:200))
        container?.center = view.center
        container?.contentMode = .scaleAspectFit
        container?.image = #imageLiteral(resourceName: "volvo_s60")
        view.addSubview(container!)
        
        // Para hacer interactuable tus subvistas de "view"
        container?.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panDetected(sender:)))
        container?.addGestureRecognizer(panGesture!)
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchDetected(sender:)))
        view.addGestureRecognizer(pinchGesture!)
        
        rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationDetected(sender:)))
        view.addGestureRecognizer(rotationGesture!)
        
    }

    @objc func panDetected(sender: UIPanGestureRecognizer){
        print("Pan detected!")
    }
    
    @objc func pinchDetected(sender: UIPinchGestureRecognizer){
        print("Pinch detected!")
    }
    
    @objc func rotationDetected(sender: UIRotationGestureRecognizer){
        print("Rotation detected!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

