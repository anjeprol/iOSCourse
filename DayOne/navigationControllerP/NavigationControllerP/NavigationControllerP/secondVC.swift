//
//  secondVC.swift
//  NavigationControllerP
//
//  Created by Antonio Prado on 4/9/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class secondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Existo!")
        
        let next = UIButton(frame: CGRect(x:10, y:0, width: 200, height:30))
        next.center = view.center
        next.setTitle("Siguiente", for: UIControlState.normal)
        next.setTitleColor(UIColor.black, for: UIControlState.normal)
        next.addTarget(self, action: #selector(nextPressed), for: UIControlEvents.touchUpInside)
        view.addSubview(next)

        view.backgroundColor = UIColor.magenta
        
        // Do any additional setup after loading the view.
    }
    
    @objc func nextPressed(){
        let second = UIViewController()
        
        // Optional chaining
        navigationController?.show(second, sender: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        print("ahí te voy")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ya llegue")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        print("ya me voy")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ya llegue")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
