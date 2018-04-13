//
//  ViewController.swift
//  camara
//
//  Created by Antonio Prado on 4/12/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pickerController: UIImagePickerController?

    override func viewDidLoad() {
        super.viewDidLoad()
        let camaraButton = UIButton(type: .system)
        camaraButton.frame = CGRect(x:0, y:0, width: 200, height: 50)
        camaraButton.center = view.center
        camaraButton.setTitle("Take a picture", for: .normal)
        camaraButton.setTitleColor(.purple, for: .normal)
        camaraButton.addTarget(self, action: #selector(takePicture), for: .touchUpInside)
        view.addSubview(camaraButton)
    }
    
    @objc func takePicture(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController = UIImagePickerController()
            pickerController?.sourceType = .camera
            pickerController?.cameraCaptureMode = .photo
            pickerController?.cameraDevice = .rear
            pickerController?.cameraFlashMode = .auto
            pickerController?.delegate = self
            
            present(pickerController!, animated: true, completion: nil)
            
        } else {
            print("Ooooops seems that you don't hava a camera, keep trying!!")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print(info)
        let picture = info[UIImagePickerControllerOriginalImage] as? UIImage
        for subview in view.subviews where subview is UIImageView {
            subview.removeFromSuperview()
        }
        
        let container = UIImageView(frame: CGRect(x: 10, y: view.frame.height/2+40, width: view.frame.width-20, height: view.frame.height/2-50))
        container.image = picture
        view.addSubview(container)
        container.contentMode = .scaleAspectFit
        
        picker.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

