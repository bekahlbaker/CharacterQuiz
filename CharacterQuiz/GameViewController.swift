//
//  GameViewController.swift
//  Comic-Quiz.com
//
//  Created by Rebekah Baker on 10/11/16.
//  Copyright © 2016 Rebekah Baker. All rights reserved.
//

import UIKit
import CoreData


class GameViewController: UIViewController, UITextFieldDelegate {
    
    var scores: [NSManagedObject] = []
    var currentGuess = 0
    var gameFinished = false
    var correctGuess = false

    @IBOutlet weak var headshotImg: UIImageView!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessTrackerLbl: Buttons!
    @IBOutlet weak var submitButton: Buttons!
    @IBAction func submitPressed(_ sender: Buttons) {
        
        let pList = Bundle.main.path(forResource: "Characters", ofType: "plist")
        guard let content = NSDictionary(contentsOfFile: pList!) as? [String:[String]] else {
            fatalError()
        }
        guard let bios = content["Bios"] else { fatalError() }
        guard let characterArray = content["Character"] else { fatalError() }
         if currentGuess < characterArray.count {
            if guessTextField.text?.lowercased().replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "the", with: "").replacingOccurrences(of: ".", with: "") == characterArray[currentGuess] {
                view.endEditing(true)
                bioLbl.text = bios[currentGuess]
                correctAnswer()
            } else {
                view.endEditing(true)
                submitButton.incorrectButton()
            }
        }
    }
    
    func correctAnswer() {
        submitButton.correctButton()
        skipButton.isHidden = true
        nextBtn.isHidden = false
        GameData.currentScore += 1
        print("CURRENT SCORE \(GameData.currentScore)")
        bioLbl.isHidden = false
        submitButton.isEnabled = false
        correctGuess = true
    }
    
    @IBOutlet weak var bioLbl: UITextView!
    @IBOutlet weak var skipButton: Buttons!
    @IBAction func skipPressed(_ sender: Buttons) {
        print("CURRENT GUESS \(currentGuess)")
        let pList = Bundle.main.path(forResource: "Characters", ofType: "plist")
        guard let content = NSDictionary(contentsOfFile: pList!) as? [String:[String]] else {
            fatalError()
        }
        guard let characterArray = content["Character"] else { fatalError() }
        if currentGuess < characterArray.count - 1 {
            currentGuess += 1
            setUpGame()
            guessTextField.becomeFirstResponder()
        } else if currentGuess >= characterArray.count - 1 {
            gameFinished = true
            performSegue(withIdentifier: "toScoreViewController", sender: nil)
        }
        print("CURRENT GUESS \(currentGuess)")
    }
    
    @IBOutlet weak var nextBtn: Buttons!
    @IBAction func nextBtnTapped(_ sender: Any) {
        print("CURRENT GUESS \(currentGuess)")
        let pList = Bundle.main.path(forResource: "Characters", ofType: "plist")
        guard let content = NSDictionary(contentsOfFile: pList!) as? [String:[String]] else {
            fatalError()
        }
        guard let characterArray = content["Character"] else { fatalError() }
        if currentGuess < characterArray.count - 1 {
            currentGuess += 1
            setUpGame()
            guessTextField.becomeFirstResponder()
            submitButton.isEnabled = true
        } else if currentGuess >= characterArray.count - 1 {
            gameFinished = true
            performSegue(withIdentifier: "toScoreViewController", sender: nil)
        }
        print("CURRENT GUESS \(currentGuess)")
    }
    
    func setUpGame() {
        print("CURRENT GUESS \(currentGuess)")
        print("CURRENT SCORE \(GameData.currentScore)")
        guessTrackerLbl.setTitle("\(currentGuess + 1)/20", for: .normal)
        guessTextField.becomeFirstResponder()
        submitButton.normalButton()
        guessTextField.text = ""
        headshotImg.image = UIImage(named: "headshot\(currentGuess + 1)")
        bioLbl.text = ""
        bioLbl.isHidden = true
        skipButton.isHidden = false
        nextBtn.isHidden = true
        correctGuess = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guessTextField.delegate = self
        guessTrackerLbl.setTitle("1/20", for: .normal)
        guessTextField.returnKeyType = UIReturnKeyType.done
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIfGameIsFinished()
        setUpGame()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var cancelBtn: Buttons!
    @IBAction func cancelBtnTapped(_ sender: Any) {
        print("CURRENT GUESS \(currentGuess)")
        performSegue(withIdentifier: "AboutVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AboutVC" {
            let aboutVc = segue.destination as? AboutViewController
            aboutVc?.gameFinished = false
            if correctGuess == true {
             aboutVc?.guessToStartAt = currentGuess + 1
            } else if correctGuess == false {
                aboutVc?.guessToStartAt = currentGuess
            }
            aboutVc?.scoreToStartAt = GameData.currentScore
        }
    }
    
    func checkIfGameIsFinished() {
        if gameFinished {
            print("Game finished")
        } else {
            print("Game not finished")
        }
    }
    
}
