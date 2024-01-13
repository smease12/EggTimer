//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//  updated by me

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard": 720]
    var counter = 0
    var timer = Timer()
    var hardness = ""
    @IBOutlet weak var topLabel: UILabel!
    var player: AVAudioPlayer!

    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        hardness = sender.currentTitle!
        counter = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateCounter() {
        
        if counter >= 0 {
            print(counter)
            print (hardness)
            counter -= 1
            
            
            if counter == 0{
                timer.invalidate()
                topLabel.text = "DONE!"
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }
            
            switch hardness{
            case "Soft": progressBar.progress = Float(eggTimes["Soft"]! - counter) / Float(eggTimes["Soft"]!)
            case "Medium": progressBar.progress = Float(eggTimes["Medium"]! - counter) / Float(eggTimes["Medium"]!)
            case "Hard": progressBar.progress = Float(eggTimes["Hard"]! - counter) / Float(eggTimes["Hard"]!)
            default: progressBar.progress = 0
            }
        }
    }
}
