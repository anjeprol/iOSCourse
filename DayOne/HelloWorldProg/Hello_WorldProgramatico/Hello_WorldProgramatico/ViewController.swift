//
//  ViewController.swift
//  Hello_WorldProgramatico
//
//  Created by Antonio Prado on 4/9/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myLabel: UILabel?
    var sayHelloB: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myLabel = UILabel(frame: CGRect(x:10, y:150, width: view.frame.width-20, height:30))
        myLabel?.textAlignment = NSTextAlignment.center
        myLabel?.textColor = UIColor.purple
        myLabel?.text = "..."
        view.addSubview(myLabel!)
        
        sayHelloB = UIButton(type: UIButtonType.system)
        sayHelloB?.frame = CGRect(x:10, y:myLabel!.frame.maxY+20, width: view.frame.width-20, height: 30)
        sayHelloB?.setTitle("Say hello", for: UIControlState.normal)
        sayHelloB?.setTitleColor(UIColor.blue, for: UIControlState.normal)
        sayHelloB?.addTarget(self, action: #selector(sayHelloPressed), for: UIControlEvents.touchUpInside)
        view.addSubview(sayHelloB!)
    }
    
    @objc func sayHelloPressed(){
        myLabel?.text = "Hello, there 😎!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

