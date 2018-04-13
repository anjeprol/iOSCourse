//
//  ProfileVC.swift
//  MiApp
//
//  Created by Gabriel on 12/04/18.
//  Copyright © 2018 Gabriel. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var container: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        container = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        container?.center = view.center
        container?.layer.cornerRadius = 50
        container?.backgroundColor = .gray
        container?.layer.masksToBounds = true
        view.addSubview(container!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapPressed))
        tapGesture.numberOfTapsRequired = 2
        container?.isUserInteractionEnabled = true
        container?.addGestureRecognizer(tapGesture)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let logoutB = UIBarButtonItem(image: #imageLiteral(resourceName: "door_icon"), style: .plain, target: self, action: #selector(logoutPressed))
        toolbar.items = [leftSpace, logoutB]
        view.addSubview(toolbar)
    }
    
    @objc func logoutPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func tapPressed() {
        print("Picture pressed")
        
        let actionSheet = UIAlertController(title: "Mi App", message: "¿Qué quieres hacer?", preferredStyle: .actionSheet)
        let takePicture = UIAlertAction(title: "Take picture", style: .default, handler: {_ in
            
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        })
        let choosePicture = UIAlertAction(title: "Choose picture", style: .default, handler: {_ in
            print("Choose")
            
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        })
        let sharePicture = UIAlertAction(title: "Share", style: .default, handler: {_ in
            print("Share")
            
            if self.container!.image != nil {
                let activity = UIActivityViewController(activityItems: [self.container!.image!], applicationActivities: nil)
                
                //iPhone
                self.present(activity, animated: true, completion: nil)
                
                //iPad
 /*
                actionSheet.modalPresentationStyle = .popover
                
                if let presenter = actionSheet.popoverPresentationController {
                    presenter.sourceView = self.view
                    presenter.sourceRect = CGRect(x: self.view.frame.width/2, y: 100, width: 0, height: 0)
                }
                
                self.present(actionSheet, animated: true, completion: nil)*/
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            print("Cancel")
        })
        
        actionSheet.addAction(takePicture)
        actionSheet.addAction(choosePicture)
        actionSheet.addAction(sharePicture)
        actionSheet.addAction(cancel)
        
        actionSheet.modalPresentationStyle = .popover
        
        if let presenter = actionSheet.popoverPresentationController {
            presenter.sourceView = view
            presenter.sourceRect = view.bounds
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        container?.image = image
        
        picker.dismiss(animated: true, completion: {
            
            if image != nil {
                let alert = UIAlertController(title: "Mi App", message: "¿Te gustaría guardar está foto?", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {_ in
                    UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
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
