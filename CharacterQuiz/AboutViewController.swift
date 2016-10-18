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
    

    @IBAction func howToPlayPressed(_ sender: UIButton) {
    
        self.blurView.isHidden = false
        self.howToPlayView.isHidden = false
        
    }
    
    @IBAction func closeHowToPlayPressed(_ sender: UIButton) {
        
        blurView.isHidden = true
        howToPlayView.isHidden = true
    }
    
    
    
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var howToPlayView: UIView!
    
    
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
            
            print(scores)
            
            if scores.count > 0 {
                
                let max = scores.first
                print(max?.value(forKey: "highScore") as! Int)
                
                self.currentHighScoreLbl.text = String(max?.value(forKey: "highScore") as! Int)
                
            } else {
                yourCurrentScoreLbl.isHidden = true
                currentHighScoreLbl.isHidden = true
                shareScoreBtn.isHidden = true
                levelLbl.isHidden = true
                levelAcheivedLbl.isHidden = true
            }

            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callHighScore()
        
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

        
        
        blurView.isHidden = true
        howToPlayView.isHidden = true
        
}
    
    
    @IBOutlet weak var yourCurrentScoreLbl: UILabel!
    @IBOutlet weak var currentHighScoreLbl: UILabel!
    @IBOutlet weak var levelAcheivedLbl: UILabel!
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var shareScoreBtn: Buttons!
    @IBAction func shareScorePressed(_ sender: Buttons) {
        
        let score = currentHighScoreLbl.text
        
        if let scoreToShare = score {
            // text to share
            let text = "My high score on Comic-Quiz.com is \(scoreToShare)!"
        
        // set up activity view controller
        let objectsToShare: [AnyObject] = [ text as AnyObject ]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
            
        }
    }

    
}
