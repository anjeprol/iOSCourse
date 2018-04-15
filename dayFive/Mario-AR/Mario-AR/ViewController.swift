//
//  ViewController.swift
//  Mario-AR
//
//  Created by Gabriel Alejandro Briseño Alvarez on 24/03/18.
//  Copyright © 2018 Gabriel Alejandro Briseño Alvarez. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate {
    
    var sceneView: ARSCNView?
    let configuration = ARWorldTrackingConfiguration()
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ARWorldTrackingConfiguration.isSupported {
        
            sceneView = ARSCNView(frame: view.frame)
            sceneView?.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
            sceneView?.session.run(configuration)
            sceneView?.session.delegate = self
            sceneView?.showsStatistics = true
            sceneView?.autoenablesDefaultLighting = true
            view.addSubview(sceneView!)
            
            let addButton = UIButton(frame: CGRect(x: 5, y: view.frame.height-80, width: view.frame.width/2-10, height: 50))
            addButton.setTitle("Agregar", for: .normal)
            addButton.setTitleColor(.white, for: .normal)
            addButton.backgroundColor = .purple
            addButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
            view.addSubview(addButton)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sceneTapped(sender:)))
            sceneView?.addGestureRecognizer(tapGestureRecognizer)
        } else {
            print("NO LO SOPORTA")
            let alertController = UIAlertController(title: "Ups", message: "Something went wrong :(", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func addPressed() {
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.01))
        cubeNode.geometry?.firstMaterial?.specular.contents = UIColor.white
        cubeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        cubeNode.position = SCNVector3(0.2,0.3,-0.2)
        cubeNode.name = "cube_1"
        
        sceneView?.scene.rootNode.addChildNode(cubeNode)
    }
    
    @objc func sceneTapped(sender: UITapGestureRecognizer) {
        let point = sender.location(in: sceneView!)
        let result = sceneView?.hitTest(point, options: nil)
    
        if result!.count > 0 {
            
            if let name = result?.first?.node.name {
                if  name == "cube_1"  {
                    let path = Bundle.main.path(forResource: "coin", ofType: "mp3")!
                    audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    audioPlayer?.prepareToPlay()
                    audioPlayer?.play()
                }
           }
        }
    }
    
    //MARK: ARSessionDelegate

    //Informs the delegate of changes to the quality of ARKit's device position tracking.
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        if let currentFrame = session.currentFrame {
            updateSessionInfoLabel(for: currentFrame, trackingState: currentFrame.camera.trackingState)
        }
    }

    func updateSessionInfoLabel(for frame: ARFrame, trackingState: ARCamera.TrackingState) {
        
        var message: String
        
        switch trackingState {
            case .normal where frame.anchors.isEmpty:
                message = "Move the device around to detect horizontal surfaces."
            case .normal:
                // No feedback needed when tracking is normal and planes are visible.
                message = "No feedback needed when tracking is normal and planes are visible."
            case .notAvailable:
                message = "Tracking unavailable."
            case .limited(.excessiveMotion):
                message = "Tracking limited - Move the device more slowly."
            case .limited(.insufficientFeatures):
                message = "Tracking limited - Point the device at an area with visible surface detail, or improve lighting conditions."
            case .limited(.initializing):
                message = "Initializing AR session."
        
            case .limited(.relocalizing):
                message = ""
        }
        
        let alertController = UIAlertController(title: "Ups", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

