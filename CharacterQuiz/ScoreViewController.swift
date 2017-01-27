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
        performSegue(withIdentifier: "AboutVC", sender: nil)
    }
    
    @IBAction func homePressed(_ sender: Buttons) {
        GameData.currentScore = 0
        performSegue(withIdentifier: "AboutVC", sender: nil)
    }
    
    @IBAction func shareScorePressed(_ sender: Buttons) {
        if let score = scoreLbl.text {
            shareTextImageAndURL(sharingText: "I just scored \(score)/20 on the Comic-Quiz.com App!", sharingURL: NSURL(string: "http://comic-quiz.com/"))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scoreLbl.text = String(GameData.currentScore)
        self.save(highScore: Int(GameData.currentScore))
        setLevel()
    }
    
    @IBAction func webViewPressed(_ sender: UIButton) {
        if let url = NSURL(string: "http://comic-quiz.com/"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AboutVC" {
            let aboutVc = segue.destination as? AboutViewController
            aboutVc?.gameFinished = true
        }
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
    
    func setLevel() {
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
    
    func shareTextImageAndURL(sharingText: String?, sharingURL: NSURL?) {
        var sharingItems = [AnyObject]()
        
        if let text = sharingText {
            sharingItems.append(text as AnyObject)
        }
        if let url = sharingURL {
            sharingItems.append(url)
        }
        
        let alert = UIAlertController(title: "Shared to Facebook!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.addToReadingList, UIActivityType.postToVimeo]
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.present(alert, animated: true, completion: nil)
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
        
    }
}
