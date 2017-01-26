//
//  ScoreViewController.swift
//  Comic-Quiz.com
//
//  Created by Rebekah Baker on 10/11/16.
//  Copyright © 2016 Rebekah Baker. All rights reserved.
//

import UIKit
import CoreData

class ScoreViewController: UIViewController {
    
    var scores: [NSManagedObject] = []
    
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBAction func playAgainPressed(_ sender: Buttons) {
        GameData.currentScore = 0
    }
    @IBAction func shareScorePressed(_ sender: Buttons) {
    }
    
    
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

    override func viewDidAppear(_ animated: Bool) {
        scoreLbl.text = String(GameData.currentScore)
        self.save(highScore: Int(GameData.currentScore))
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
    
    @IBAction func webViewPressed(_ sender: UIButton) {
        if let url = NSURL(string: "http://comic-quiz.com/"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
  
}
