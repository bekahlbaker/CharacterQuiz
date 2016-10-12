//
//  ScoreViewController.swift
//  CharacterQuiz
//
//  Created by Rebekah Baker on 10/11/16.
//  Copyright © 2016 Rebekah Baker. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBAction func playAgainPressed(_ sender: Buttons) {
    }
    @IBAction func shareScorePressed(_ sender: Buttons) {
        
        // text to share
        let text = "My high score on Comic-Quiz.com is \(String(GameData.currentScore))!"
        
        // set up activity view controller
        let objectsToShare: [AnyObject] = [ text as AnyObject ]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLbl.text = String(GameData.currentScore)
        
        let score = GameData.currentScore
        
        UserDefaults.standard.set(score, forKey: "score")
        
        if GameData.currentScore == 0 {
            
            levelLbl.text = "Ignorant"
        }
        if (GameData.currentScore >= 1) && (GameData.currentScore <= 7) {
            
            levelLbl.text = "Novice"
        }
        if (GameData.currentScore >= 8) && (GameData.currentScore <= 16) {
            
            levelLbl.text = "Apprentice"
        }
        if (GameData.currentScore >= 17) && (GameData.currentScore <= 24) {
            
            levelLbl.text = "Intermediate"
        }
        if (GameData.currentScore >= 25) && (GameData.currentScore <= 32) {
            
            levelLbl.text = "Advanced"
        }
        if (GameData.currentScore >= 33) && (GameData.currentScore <= 38) {
            
            levelLbl.text = "Master"
        }
        if GameData.currentScore == 39 {
            
            levelLbl.text = "Expert"
        }
    }
}

//Enter in character bio

//AppIcon

//Deadpool?
