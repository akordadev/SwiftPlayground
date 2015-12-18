//
//  ViewController.swift
//  BullsEye
//
//  Created by Matt Cielecki on 12/15/15.
//  Copyright © 2015 Matt Cielecki. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    var timer = NSTimer()
    var increaseTimer: Float = 1.0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //set images for scroll bar
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("animateSlider"), userInfo: nil, repeats: true)
        updateLabels()
    }
    
    func animateSlider() {
        if(slider.value >= 100.0) {
            increaseTimer = -1
        } else if(slider.value <= 1.0){
            increaseTimer = 1
        }
            slider.value += increaseTimer
    }
    func updateLabels() {
        targetLabel.text = "\(targetValue)"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    @IBAction func showAlert() {
        timer.invalidate()
        currentValue = lroundf(slider.value)
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        round++

        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        score += points
        let message = "The value of the slider is: \(currentValue)" + "\nThe target value is: \(targetValue)" +
                        "\nYour score this round is \(points)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        //callback closure to start new round and update after the alert window is closed
        let action = UIAlertAction(title: "OK", style: .Default) {
            action in
            self.startNewRound()
            self.updateLabels()
        }
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        print("The value of the slider is now: \(slider.value)")
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        //QuartzCore transition
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }

}

