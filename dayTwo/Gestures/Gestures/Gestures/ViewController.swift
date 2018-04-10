//
//  ViewController.swift
//  Gestures
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate{
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
        
        pinchGesture?.delegate = self
        rotationGesture?.delegate = self
        
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func panDetected(sender: UIPanGestureRecognizer){
        print("Pan detected!")
        
        let transition = sender.translation(in: view)
        container?.center = CGPoint(x:container!.center.x+transition.x, y:container!.center.y+transition.y)
        sender.setTranslation(.zero, in: view)
    }
    
    @objc func pinchDetected(sender: UIPinchGestureRecognizer){
        
        if sender.state == .began {
            print("Pinch began")
        } else if sender.state == .changed {
            print("Pinch detected with sacale: \(sender.scale)")
            container?.transform = container!.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        } else if sender.state == .ended {
            
        }
    }
    
    @objc func rotationDetected(sender: UIRotationGestureRecognizer){
        print("Rotation detected!")
        
        let radians = sender.rotation
        container?.transform = container!.transform.rotated(by: radians)
        
        sender.rotation = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

