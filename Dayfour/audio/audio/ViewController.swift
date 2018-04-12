//
//  ViewController.swift
//  audio
//
//  Created by Antonio Prado on 4/12/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit
import AVFoundation //Usado para reproducir audios

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    var barView: UIView?
    var stopButton: UIButton?
    var playButton: UIButton?
    var pauseButton: UIButton?
    var progressView: UIProgressView?
    var progressValue: Double?
    var timer: Timer?
    var volume: UISlider?
    var maximumVolume: UIImageView?
    var minimumVolume: UIImageView?
    
    //Variable computada
    var isItOpen = false {
        willSet {
            if newValue {
                //Agregamos los nuevos elementos a la barra
                volume = UISlider(frame: CGRect(x: 55, y: 100, width: kWidth-110, height: 5))
                volume?.addTarget(self, action: #selector(volumeChanged(sender:)), for: .valueChanged)
                volume?.minimumValue = 0.0
                volume?.maximumValue = 1.0
                volume?.value = 0.5
                volume?.minimumTrackTintColor = UIColor(red: 88/255, green: 1, blue: 8/255, alpha: 1)
                barView?.addSubview(volume!)
                
                minimumVolume = UIImageView(frame: CGRect(x: 12.5, y: 90, width: 30, height: 30))
                minimumVolume?.image = #imageLiteral(resourceName: "Mute")
                barView?.addSubview(minimumVolume!)
                
                maximumVolume = UIImageView(frame: CGRect(x: kWidth-42.5, y: 90, width: 30, height: 30))
                maximumVolume?.image = #imageLiteral(resourceName: "HighVolume")
                barView?.addSubview(maximumVolume!)
                
            } else {
                volume?.removeFromSuperview()
                minimumVolume?.removeFromSuperview()
                maximumVolume?.removeFromSuperview()
            }
        }
        
        didSet {
            
        }
    }
    
    enum ControlButtons: Int {
        case Stop = 0
        case Pause = 1
        case Play = 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The AVAudioPlayer class does not provide support for streaming audio based on HTTP URL's. The URL used with initWithContentsOfURL: must be a File URL (file://). That is, a local pat
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight))
        let request = URLRequest(url: URL(string: "https://www.code3e.com/JSON/01_Riding_With_the_King.mp3")!)
        webView.loadRequest(request)
        view.addSubview(webView)
        
        
        if let path = Bundle.main.path(forResource: "Satisfaction", ofType: "mp3") {
            
            let url = URL(fileURLWithPath: path)
            //let url = URL(string: "https://www.code3e.com/JSON/01_Riding_With_the_King.mp3")
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        loadUI()
    }
    
    func loadUI() {
        barView = UIView(frame: CGRect(x: 0, y: view.frame.height-50, width: view.frame.width, height: 50))
        barView?.backgroundColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        view.addSubview(barView!)
        
        //Buttons
        stopButton = UIButton(frame: CGRect(x: view.frame.width/2, y: 5, width: 40, height: 40))
        stopButton?.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
        stopButton?.addTarget(self, action: #selector(controlPressed(sender:)), for: .touchUpInside)
        stopButton?.tag = ControlButtons.Stop.hashValue
        barView?.addSubview(stopButton!)
        
        playButton = UIButton(frame: CGRect(x: stopButton!.frame.minX+50, y: 5, width: 40, height: 40))
        playButton?.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
        playButton?.addTarget(self, action: #selector(controlPressed(sender:)), for: .touchUpInside)
        playButton?.tag = ControlButtons.Play.hashValue
        barView?.addSubview(playButton!)
        
        pauseButton = UIButton(frame: CGRect(x: playButton!.frame.minX+50, y: 5, width: 40, height: 40))
        pauseButton?.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
        pauseButton?.addTarget(self, action: #selector(controlPressed(sender:)), for: .touchUpInside)
        pauseButton?.tag = ControlButtons.Pause.hashValue
        barView?.addSubview(pauseButton!)
        
        //Progress view
        progressView = UIProgressView(frame: CGRect(x:0, y:0, width: view.frame.width, height: 0))
        progressView?.trackTintColor = UIColor(red:74/255, green: 74/255, blue:74/255, alpha: 1)
        progressView?.progressTintColor = UIColor(red: 80/255, green: 1, blue: 80/255, alpha: 1)
        barView?.addSubview(progressView!)
        
        let up_down = Up_Down (frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        up_down.image = #imageLiteral(resourceName: "Up")
        up_down.referenceToController = self
        barView?.addSubview(up_down)

    }
    
    @objc func controlPressed(sender: UIButton) {
        switch sender.tag {
        case ControlButtons.Play.hashValue:
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            // Para que se vea como avanza la barra mientras reproduce la canción
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (_) in
               self.progressView?.progress = Float(self.audioPlayer!.currentTime/self.audioPlayer!.duration)
            })
            
        case ControlButtons.Pause.hashValue:
            audioPlayer?.pause()
        case ControlButtons.Stop.hashValue:
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
            // Cuando se usen timers, siempre deben ser invalidados, esto es debido a que el timer esta en un ciclo
            timer = nil
        default: break
        }
        
    }
    
    @objc func volumeChanged(sender: UISlider){
        print(sender.value)
        audioPlayer?.volume = sender.value
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

