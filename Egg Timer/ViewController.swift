//
//  ViewController.swift
//  Egg Timer
//
//  Created by Konstantin on 30.03.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    
    private let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    private var totalTime = 0
    private var secondPassed = 0
    private var timer = Timer()
    private var player: AVAudioPlayer?
    private var nameSoundTimer = "alarm_sound"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        progressBar.setProgress(0, animated: true)
        secondPassed = 0
        
        let hardness = sender.titleLabel?.text ?? "error"
        
        textLabel.text = "You should \(hardness)"
        
        totalTime = eggTimes[hardness] ?? 0
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
    }
    
    private func playSound(_ soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    @objc private func updateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            progressBar.setProgress(percentageProgress, animated: true)
        } else {
            playSound(nameSoundTimer)
            timer.invalidate()
            secondPassed = 0
            textLabel.text = "That's done! Let's go repeats?"
            progressBar.setProgress(1, animated: true)
        }
    }
    

}

