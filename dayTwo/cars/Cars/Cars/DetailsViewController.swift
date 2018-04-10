//
//  DetailsViewController.swift
//  Cars
//
//  Created by Antonio Prado on 4/10/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var data: [Any]? //Any -> String, Array, Dictionary

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let container = UIImageView(frame: CGRect(x:15, y:100, width: view.frame.width-30, height: 200))
        container.image = data?[0] as? UIImage
        container.contentMode = .scaleAspectFit
        view.addSubview(container)  //Para colocar una imagen con aspecto dado x... ejemplo, si la imagen es más chica que el contenedor, puedes escalar la imagen para rellenar el contenedor.
        
        
        let makeL = UILabel(frame: CGRect(x:0, y: container.frame.maxY, width: view.frame.width, height: 30))
        makeL.textAlignment = .center
        makeL.text = "Make:  " + ((data?[1] as? String) ?? "No especificado")
        view.addSubview(makeL)
        
        let modelL = UILabel(frame: CGRect(x:0, y: container.frame.maxY+50, width: view.frame.width, height: 30))
        modelL.textAlignment = .center
        modelL.text = "Model:  " + ((data?[2] as? String) ?? "No especificado")
        view.addSubview(modelL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
