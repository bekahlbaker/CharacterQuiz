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
    
    func save(highScore: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Score", in: managedContext)!
        let score = NSManagedObject(entity: entity, insertInto: managedContext)
        score.setValue(highScore, forKey: "highScore")
        do{
            try managedContext.save()
            scores.append(score)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    var headshotImageCurrent = 2
    var currentGuess = 0
    static var gameFinished = false

    @IBOutlet weak var headshotImg: UIImageView!
    @IBOutlet weak var guessTextField: UITextField!
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
                submitButton.correctButton()
                skipButton.isHidden = true
                GameData.currentScore += 1
                print(GameData.currentScore)
                bioLbl.isHidden = false
                bioLbl.text = bios[currentGuess]
                submitButton.isEnabled = false
                self.save(highScore: Int(GameData.currentScore))
                checkIfGameIsFinished()
            } else {
                view.endEditing(true)
                submitButton.incorrectButton()
            }
        }
    }


    @IBOutlet weak var bioLbl: UITextView!
    @IBOutlet weak var skipButton: Buttons!
    @IBAction func skipPressed(_ sender: Buttons) {
        let pList = Bundle.main.path(forResource: "Characters", ofType: "plist")
        guard let content = NSDictionary(contentsOfFile: pList!) as? [String:[String]] else {
            fatalError()
        }
        guard let characterArray = content["Character"] else { fatalError() }
        if currentGuess < characterArray.count - 1 {
            currentGuess += 1
            submitButton.normalButton()
//            nextSkipButton.skipButton()
            guessTextField.text = ""
            bioLbl.isHidden = true
            bioLbl.text = ""
            headshotImg.image = UIImage(named: "headshot\(headshotImageCurrent)")
            headshotImageCurrent += 1
            guessTextField.becomeFirstResponder()
        } else if currentGuess >= characterArray.count - 1 {
            GameViewController.gameFinished = true
            performSegue(withIdentifier: "toScoreViewController", sender: nil)
        }
    }
    
    @IBOutlet weak var nextBtn: Buttons!
    @IBAction func nextBtnTapped(_ sender: Any) {
        let pList = Bundle.main.path(forResource: "Characters", ofType: "plist")
        guard let content = NSDictionary(contentsOfFile: pList!) as? [String:[String]] else {
            fatalError()
        }
        guard let characterArray = content["Character"] else { fatalError() }
        if currentGuess < characterArray.count - 1 {
            currentGuess += 1
            submitButton.normalButton()
            skipButton.isHidden = false
            guessTextField.text = ""
            bioLbl.isHidden = true
            bioLbl.text = ""
            headshotImg.image = UIImage(named: "headshot\(headshotImageCurrent)")
            headshotImageCurrent += 1
            guessTextField.becomeFirstResponder()
            submitButton.isEnabled = true
        } else if currentGuess >= characterArray.count - 1 {
            GameViewController.gameFinished = true
            performSegue(withIdentifier: "toScoreViewController", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guessTextField.delegate = self
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIfGameIsFinished()
        GameData.currentScore = 0
        guessTextField.becomeFirstResponder()
        submitButton.normalButton()
//        nextSkipButton.skipButton()
        guessTextField.text = ""
        headshotImg.image = UIImage(named: "headshot1")
        bioLbl.text = ""
        bioLbl.isHidden = true
        guessTextField.returnKeyType = UIReturnKeyType.done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBOutlet weak var cancelBtn: Buttons!
    @IBAction func cancelBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "AboutVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AboutVC" {
            GameViewController.gameFinished = false
            let scoreToSend = GameData.currentScore
            let aboutVc = segue.destination as? AboutViewController
            aboutVc?.scorePassed = scoreToSend
            checkIfGameIsFinished()
        }
    }
    
    func checkIfGameIsFinished() {
        if GameViewController.gameFinished {
            print("Game finished")
        } else {
            print("Game not finished")
        }
    }
    
}
