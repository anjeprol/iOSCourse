//
//  ViewController.swift
//  Cars
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView?
    let cars = [ #imageLiteral(resourceName: "chevy_volt"), #imageLiteral(resourceName: "mini_clubman"), #imageLiteral(resourceName: "smart_fortwo"), #imageLiteral(resourceName: "toyota_venza"), #imageLiteral(resourceName: "volvo_s60") ]
    let models = ["Volt", "Clubman", "ForTwo", "Venza", "s60"]
    let makes = ["Chevy", "mini", "Smart", "Toyota", "Volvo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView = UITableView(frame: view.frame)
        tableView?.dataSource = self
        tableView?.delegate = self 
        tableView?.alwaysBounceVertical = false
        view.addSubview(tableView!)
    }
    
    //MARK: TableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell(width: models[indexPath.row], with: makes[indexPath.row], with: cars[indexPath.row])
        cell?.backgroundColor = UIColor(red:25/255, green: 45/255, blue:59/255, alpha: 1)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = DetailsViewController()
        details.data = [cars[indexPath.row], makes[indexPath.row], models[indexPath.row]]
        navigationController?.pushViewController(details, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

