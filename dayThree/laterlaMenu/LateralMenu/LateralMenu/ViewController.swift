//
//  ViewController.swift
//  LateralMenu
//
//  Created by Antonio Prado on 4/11/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var menuView: UIView?
    var swipeToOpen: UISwipeGestureRecognizer?
    var swipeToClose: UISwipeGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        menuView = UIView(frame: CGRect(x:-30, y:0, width:300, height: view.frame.height))
        menuView?.backgroundColor = .yellow
        view.addSubview(menuView!)
        
        swipeToOpen = UISwipeGestureRecognizer(target: self, action: #selector(openMenu))
        swipeToOpen?.direction = .right
        swipeToOpen?.numberOfTouchesRequired = 1
        view.addGestureRecognizer(swipeToOpen!)
        
        swipeToClose = UISwipeGestureRecognizer(target: self, action: #selector(closeMenu))
        swipeToClose?.direction = .left
        swipeToClose?.numberOfTouchesRequired = 1
        view.addGestureRecognizer(swipeToClose!)
        
        let tableView = UITableView(frame: CGRect(x:60, y:100, width:menuView!.frame.width-70, height: view.frame.height-110))
        tableView.dataSource = self
        menuView?.addSubview(tableView)
    }
    
    @objc func openMenu(){
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveLinear, animations: {
            
            // Abrimos el menu
            self.menuView?.frame = CGRect(x: -50, y:0, width: 300, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc func closeMenu (){

        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveLinear, animations: {
            
            // Abrimos el menu
            self.menuView?.frame = CGRect(x: -300, y:0, width: 300, height: self.view.frame.height)
        }, completion: {(flag) in
            
            //Que quieres hacer cuando termine la animacion
        })
    }
    
    //MARK
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell (style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Section: \(indexPath.section), row: \(indexPath.row)"
        cell.backgroundColor = .lightGray
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

