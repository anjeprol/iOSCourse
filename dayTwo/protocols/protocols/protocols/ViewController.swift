//
//  ViewController.swift
//  protocols
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MasterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let master = Master()
        master.delegate = self
    }
    
    // MARK: MasterDelegate
    func greeting(to name: String) {
        print("hi there!")
    }
    
    func requestHowMuchMixDoYouNeed() -> Double {
        return 120.2
    }
    
    func mixReadyToUse() {
        print("Thanks a lot!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

