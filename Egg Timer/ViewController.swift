//
//  ViewController.swift
//  Egg Timer
//
//  Created by Konstantin on 30.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textLabel: UILabel!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var secondRemaining = 60
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.titleLabel?.text ?? "error"
        
        textLabel.text = "You should \(hardness)"
        
        secondRemaining = eggTimes[hardness] ?? 0
        secondRemaining /= 60
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func updateTimer() {
        if secondRemaining > 0 {
            let minutes = String(secondRemaining / 60)
            let seconds = String(secondRemaining % 60)
            print(minutes + ":" + seconds)
            secondRemaining -= 1
        } else {
            timer.invalidate()
            textLabel.text = "That's done! Let's go repeats?"
        }
    }
    

}

