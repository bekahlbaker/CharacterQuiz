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
                nextSkipButton.nextButton()
                
                GameData.currentScore += 1


                
                bioLbl.isHidden = false
                bioLbl.text = bios[currentGuess]
                
            } else {
                
                view.endEditing(true)
                submitButton.incorrectButton()
            }
        }
    }


    @IBOutlet weak var bioLbl: UITextView!
    
    @IBOutlet weak var nextSkipButton: Buttons!
    
    @IBAction func nextSkipPressed(_ sender: Buttons) {
        
        let pList = Bundle.main.path(forResource: "Characters", ofType: "plist")
        guard let content = NSDictionary(contentsOfFile: pList!) as? [String:[String]] else {
            
            fatalError()
        }
        guard let characterArray = content["Character"] else { fatalError() }
        
        if currentGuess < characterArray.count - 1 {
            
            currentGuess += 1
            submitButton.normalButton()
            nextSkipButton.skipButton()
            guessTextField.text = ""
            bioLbl.isHidden = true
            bioLbl.text = ""
            headshotImg.image = UIImage(named: "headshot\(headshotImageCurrent)")
            headshotImageCurrent += 1
            guessTextField.becomeFirstResponder()
            
        } else if currentGuess >= characterArray.count - 1 {
            
            performSegue(withIdentifier: "toScoreViewController", sender: nil)
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameData.currentScore = 0
        
        guessTextField.becomeFirstResponder()
        submitButton.normalButton()
        nextSkipButton.skipButton()
        guessTextField.text = ""
        headshotImg.image = UIImage(named: "headshot1")
        bioLbl.text = ""
        bioLbl.isHidden = true
        
        guessTextField.returnKeyType = UIReturnKeyType.done
        
        self.guessTextField.delegate = self
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
}
