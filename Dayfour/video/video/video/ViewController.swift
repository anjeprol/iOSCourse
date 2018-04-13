//
//  ViewController.swift
//  video
//
//  Created by Antonio Prado on 4/12/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    var videoPlayer: AVPlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        let toolbar = UIToolbar(frame: CGRect(x:0 , y:0, width: view.frame.width, height: 70))
        
        let playButton = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playPressed))
        toolbar.items = [playButton]
        view.addSubview(toolbar)
    }
    
    @objc func playPressed(){
        let url = URL (string: "http://iphone.rtpa.stream.flumotion.com/rtpa/tv-iphone/main.m3u8")!
        videoPlayer = AVPlayerViewController()
        videoPlayer?.player = AVPlayer(url:url)
        videoPlayer?.view.frame = CGRect(x: 0, y:70 , width: view.frame.width, height:view.frame.height-70)
        videoPlayer?.player?.play()
        view.addSubview(videoPlayer!.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

