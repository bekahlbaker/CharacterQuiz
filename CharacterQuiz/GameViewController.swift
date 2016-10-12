//
//  GameViewController.swift
//  CharacterQuiz
//
//  Created by Rebekah Baker on 10/11/16.
//  Copyright © 2016 Rebekah Baker. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    var headshotImageCurrent = 2
    
    var currentGuess = 0
    
    @IBOutlet weak var headshotImg: UIImageView!
    
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBOutlet weak var submitButton: Buttons!
    @IBAction func submitPressed(_ sender: Buttons) {
        
         if currentGuess < GameData.characterArray.count {
            
            if guessTextField.text?.lowercased().replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "the", with: "").replacingOccurrences(of: ".", with: "") == GameData.characterArray[currentGuess] {
                
                view.endEditing(true)
                submitButton.correctButton()
                nextSkipButton.nextButton()
                GameData.currentScore += 1
                
            } else {
                
                view.endEditing(true)
                submitButton.incorrectButton()
            }
        }
    }

    @IBOutlet weak var bioLbl: UILabel!
    
    @IBOutlet weak var nextSkipButton: Buttons!
    
    @IBAction func nextSkipPressed(_ sender: Buttons) {
        
        if currentGuess < GameData.characterArray.count - 1 {
            
            currentGuess += 1
            submitButton.normalButton()
            nextSkipButton.skipButton()
            guessTextField.text = ""
            headshotImg.image = UIImage(named: "headshot\(headshotImageCurrent)")
            headshotImageCurrent += 1
            guessTextField.becomeFirstResponder()
            
        } else if currentGuess >= GameData.characterArray.count - 1 {
            
            performSegue(withIdentifier: "toScoreViewController", sender: nil)
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guessTextField.becomeFirstResponder()
        submitButton.normalButton()
        nextSkipButton.skipButton()
        guessTextField.text = ""
        headshotImg.image = UIImage(named: "headshot1")
        
        guessTextField.returnKeyType = UIReturnKeyType.done
        
        self.guessTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
