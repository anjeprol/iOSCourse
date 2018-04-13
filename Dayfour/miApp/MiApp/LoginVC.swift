//
//  LoginVC.swift
//  MiApp
//
//  Created by Gabriel on 12/04/18.
//  Copyright © 2018 Gabriel. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class LoginVC: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        loadUI()
    }
    
    func loadUI() {
        let playerController = AVPlayerViewController()
        let path = Bundle.main.path(forResource: "moments", ofType: "mp4")
        
        if path != nil {
            playerController.player = AVPlayer(url: URL(fileURLWithPath: path!))
            playerController.showsPlaybackControls = false
            playerController.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue
            playerController.view.frame = view.frame
            playerController.view.isUserInteractionEnabled = false
            view.addSubview(playerController.view)
            playerController.player?.play()
            
            
            // Si un parametro en una función está como último parametro, este puede aplicar como trailing closure (eliminando la etiqueta y sacando el closure)
            
            //Cuando usamos observers, siempre tenemos que remover el observer
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player!.currentItem!, queue: .main) { _ in
                    playerController.player?.seek(to: kCMTimeZero)
                    playerController.player?.play()
            }
            
            let background = UIView(frame: CGRect(x: 50, y: 50, width: view.frame.width-100, height: view.frame.height-100))
            background.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            view.addSubview(background)
            
            let nameTF = UITextField(frame: CGRect(x: 3, y: 100, width: background.frame.width-6, height: 30))
            nameTF.placeholder = " User"
            nameTF.keyboardType = .emailAddress
            nameTF.keyboardAppearance = .dark
            nameTF.returnKeyType = .next
            nameTF.borderStyle = .roundedRect
            nameTF.delegate = self
            background.addSubview(nameTF)
            
            let passwordTF = UITextField(frame: CGRect(x: 3, y: nameTF.frame.maxY+30, width: background.frame.width-6, height: 30))
            passwordTF.placeholder = " Password"
            passwordTF.isSecureTextEntry = true
            passwordTF.keyboardType = .emailAddress
            passwordTF.keyboardAppearance = .dark
            passwordTF.returnKeyType = .done
            passwordTF.borderStyle = .roundedRect
            passwordTF.delegate = self
            background.addSubview(passwordTF)
        } else {
            print("Ups, no encontre el video")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    // TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("Enter")
        
        textField.resignFirstResponder()
        
        // Construir la App
        let tabBarController = UITabBarController()
        
        let carsVC = CarsTVC()
        carsVC.tabBarItem.title = "Cars"
        carsVC.tabBarItem.image = #imageLiteral(resourceName: "car_icon")
        
        let sensorsVC = SensorsVC()
        sensorsVC.tabBarItem.title = "Sensor"
        sensorsVC.tabBarItem.image = #imageLiteral(resourceName: "device_icon")
        
        let profileVC = ProfileVC()
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = #imageLiteral(resourceName: "profile_icon")
        
        tabBarController.viewControllers = [carsVC, sensorsVC, profileVC]
        
        tabBarController.tabBar.barTintColor = .black
        tabBarController.tabBar.tintColor = .white
        
        navigationController?.show(tabBarController, sender: nil)
        
        
        return true
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
