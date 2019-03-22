//
//  ViewController.swift
//  Project2
//
//  Created by Derek Stephen McLean on 22/03/2019.
//  Copyright © 2019 Derek Stephen McLean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var flag1: UIButton!
    @IBOutlet weak var flag2: UIButton!
    @IBOutlet weak var flag3: UIButton!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var currentQuestion = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        flag1.layer.borderWidth = 1
        flag2.layer.borderWidth = 1
        flag3.layer.borderWidth = 1
        
        flag1.layer.borderColor = UIColor.lightGray.cgColor
        flag2.layer.borderColor = UIColor.lightGray.cgColor
        flag3.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        flag1.setImage(UIImage(named: countries[0]), for: .normal)
        flag2.setImage(UIImage(named: countries[1]), for: .normal)
        flag3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "Which is " + countries[correctAnswer].uppercased() + "? Current score \(score)"
    }
    
    func resetGame(action: UIAlertAction! = nil) {
        score = 0
        currentQuestion = 0
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        var label: String
        var handler = askQuestion
        
        currentQuestion += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            message = ""
            score += 1
        } else {
            title = "Wrong"
            message = "The correct answer was " + countries[correctAnswer].uppercased() + ".\n"
            score -= 1
        }
        
        if (currentQuestion < 10) {
            message += "Your score is \(score)."
            label = "Continue"
        } else {
            message += "Game over! Your final score is \(score)."
            handler = resetGame
            label = "Start Again"
        }
        
        // display a scores alert
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: label, style: .default, handler: handler))
        present(ac, animated: true)
    }
}

