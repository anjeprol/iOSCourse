//
//  ViewController.swift
//  NavigationControllerP
//
//  Created by Antonio Prado on 4/9/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        
        let next = UIButton(frame: CGRect(x:10, y:0, width: 200, height:30))
        next.center = view.center
        next.setTitle("Siguiente", for: UIControlState.normal)
        next.setTitleColor(UIColor.black, for: UIControlState.normal)
        next.addTarget(self, action: #selector(nextPressed), for: UIControlEvents.touchUpInside)
        view.addSubview(next)
        title = "General"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func nextPressed(){
        let second = secondVC()
        
        // Optional chaining
        navigationController?.show(second, sender: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

