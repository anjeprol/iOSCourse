//
//  ViewController.swift
//  Persistance
//
//  Created by Antonio Prado on 4/13/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Files
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        if fileManager.fileExists(atPath: rootPath[0]+"/picture.jpg") {
            print("Presentando")
            let getImage = fileManager.contents(atPath: rootPath[0] + "/picture.jpg")
            let imageObject = UIImage(data: getImage!)
            
            let container = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            container.center = view.center
            container.contentMode = .scaleAspectFit
            container.image = imageObject
            view.addSubview(container)
            
        } else {
            print("Guardando")
            
            let picture = UIImage(named: "pug")
            let dataPicture = UIImageJPEGRepresentation(picture!, 1)
            
            if fileManager.createFile(atPath: rootPath[0]+"/picture.jpg", contents: dataPicture, attributes: nil) {
                print("Guardado")
            } else {
                print("Hubo un error")
            }
        }
        
        //Arachiving
        
        if fileManager.fileExists(atPath: rootPath[0] + "/title.archive") {
            print("Presentando label")
            let label = NSKeyedUnarchiver.unarchiveObject(withFile: rootPath[0] + "/title.archive") as? UILabel
            view.addSubview(label!)
        } else {
            print("Guardando label")
            
            let label = UILabel(frame: CGRect(x: 0, y: view.frame.height-50, width: view.frame.width, height: 30))
            label.textColor = .purple
            label.text = "Awesome PUG!!!!"
            label.textAlignment = .center
            
            if NSKeyedArchiver.archiveRootObject(label, toFile: rootPath[0] + "/title.archive") {
                print("Label guardado")
            } else {
                print("Oops! something went wrong! ")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

