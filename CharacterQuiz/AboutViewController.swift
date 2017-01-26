//
//  AboutViewController.swift
//  Comic-Quiz.com
//
//  Created by Rebekah Baker on 10/10/16.
//  Copyright © 2016 Rebekah Baker. All rights reserved.
//

import UIKit
import CoreData


class AboutViewController: UIViewController {
    
    var scores: [NSManagedObject] = []
    var scorePassed = 0
    var highScore: Int!
    var isFirstLaunch = false
    
    @IBOutlet weak var blurViewCenter: NSLayoutConstraint!
    
    @IBAction func howToPlayPressed(_ sender: UIButton) {
        self.blurView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.blurViewCenter.constant += self.view.frame.height
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func closeHowToPlayPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.blurViewCenter.constant -= self.view.frame.height
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var howToPlayView: UIView!
    @IBOutlet weak var yourCurrentScoreLbl: UILabel!
    @IBOutlet weak var currentHighScoreLbl: UILabel!
    @IBOutlet weak var levelAcheivedLbl: UILabel!
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var shareScoreBtn: Buttons!
    @IBOutlet weak var underlineView: UIView!
    
    @IBAction func shareScorePressed(_ sender: Buttons) {
        let score = currentHighScoreLbl.text
        if let scoreToShare = score {
            let text = "My high score on Comic-Quiz.com is \(scoreToShare)!"
            let objectsToShare: [AnyObject] = [ text as AnyObject ]
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            self.present(activityViewController, animated: true, completion: nil)
            
        }
    }
    
    @IBOutlet weak var playNowBtn: Buttons!
    @IBOutlet weak var playAgainBtn: Buttons!
    
    
    func callHighScore() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Score")
        fetchRequest.fetchLimit = 1
        let sortDescriptor = NSSortDescriptor(key: "highScore", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            scores = try managedContext.fetch(fetchRequest)
            print("SCORES: \(scores)")
            if scores.count > 0 {
                let max = scores.first
                print(max?.value(forKey: "highScore") as! Int)
                highScore = max?.value(forKey: "highScore") as! Int!
                print("\(highScore)")
                currentHighScoreLbl.text = String(highScore)
            } else {
                print("No high score")
                isFirstLaunch = true
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blurView.isHidden = true
        blurViewCenter.constant -= view.frame.height
        callHighScore()
        checkIfGameIsFinished()
        
        if(!UserDefaults.standard.bool(forKey: "firstlaunch1.0")){
            isFirstLaunch = true
            print("Is a first launch")
            UserDefaults.standard.set(true, forKey: "firstlaunch1.0")
            UserDefaults.standard.synchronize();
        }
        
        if isFirstLaunch == true {
            playGame()
        }
        
        if GameViewController.gameFinished == false && GameData.currentScore >= 1 {
            finishGame()
        }
        
        if GameViewController.gameFinished == true || GameData.currentScore == 0 && isFirstLaunch == false {
            playAgain()
        }
    }
    
    func playGame() {
        print("Has never played before")
        playAgainBtn.isHidden = true
        playNowBtn.isHidden = false
        yourCurrentScoreLbl.isHidden = true
        currentHighScoreLbl.isHidden = true
        shareScoreBtn.isHidden = true
        levelLbl.isHidden = true
        levelAcheivedLbl.isHidden = true
        underlineView.isHidden = true
        
    }
    
    func finishGame() {
        print("Canceled mid-game")
        playAgainBtn.isHidden = true
        playNowBtn.isHidden = false
        playNowBtn.setTitle("Finish game", for: .normal)
        yourCurrentScoreLbl.isHidden = true
        currentHighScoreLbl.isHidden = true
        shareScoreBtn.isHidden = true
        levelLbl.isHidden = true
        levelAcheivedLbl.isHidden = true
        underlineView.isHidden = true
        
    }
    
    func playAgain() {
        print("Played all the way through")
        playAgainBtn.isHidden = false
        playNowBtn.isHidden = true
        yourCurrentScoreLbl.isHidden = false
        currentHighScoreLbl.isHidden = false
        shareScoreBtn.isHidden = false
        levelLbl.isHidden = false
        levelAcheivedLbl.isHidden = false
        underlineView.isHidden = false
        callHighScore()
        setGameLevel()
    }
    
    func setGameLevel() {
        if (GameData.currentScore >= 0) && (GameData.currentScore <= 5) {
            levelLbl.text = "Ignorant"
        }
        if (GameData.currentScore >= 6) && (GameData.currentScore <= 10) {
            levelLbl.text = "Apprentice"
        }
        if (GameData.currentScore >= 11) && (GameData.currentScore <= 15) {
            levelLbl.text = "Advanced"
        }
        if (GameData.currentScore >= 16) && (GameData.currentScore <= 20) {
            levelLbl.text = "Expert"
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
