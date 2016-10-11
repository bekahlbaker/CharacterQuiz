//
//  GameViewController.swift
//  CharacterQuiz
//
//  Created by Rebekah Baker on 10/11/16.
//  Copyright © 2016 Rebekah Baker. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var answerArray = ["flash", "penguin", "clayface", "spiderman", "deadpool", "antman", "electro", "twoface"]
    
    var headshotImageCurrent = 2
    
    var currentGuess = 0
    
    var correctAnswers = 0
    
    @IBOutlet weak var headshotImg: UIImageView!
    
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBOutlet weak var submitButton: Buttons!
    @IBAction func submitPressed(_ sender: Buttons) {
        
        if currentGuess <= answerArray.count {
            
            if guessTextField.text?.lowercased().replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "") == answerArray[currentGuess] {
                
                submitButton.correctButton()
                nextSkipButton.nextButton()
                correctAnswers += 1
                
            } else {
                
                submitButton.incorrectButton()
            }
        }
       
    }

    @IBOutlet weak var bioLbl: UILabel!
    
    @IBOutlet weak var nextSkipButton: Buttons!
    
    @IBAction func nextSkipPressed(_ sender: Buttons) {
        
        if currentGuess <= answerArray.count {
            
            currentGuess += 1
            submitButton.normalButton()
            nextSkipButton.skipButton()
            guessTextField.text = ""
            headshotImg.image = UIImage(named: "headshot\(headshotImageCurrent)")
            headshotImageCurrent += 1
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.normalButton()
        nextSkipButton.skipButton()
        guessTextField.text = ""
        headshotImg.image = UIImage(named: "headshot1")
    
    }

}
