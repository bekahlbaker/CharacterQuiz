//
//  AboutViewController.swift
//  CharacterQuiz
//
//  Created by Rebekah Baker on 10/10/16.
//  Copyright © 2016 Rebekah Baker. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurView.isHidden = true
        howToPlayView.isHidden = true
        
        let theCurrentScore = UserDefaults.standard.object(forKey: "score")
        
        if let currentHighScore = theCurrentScore as? Int {
                
                self.currentHighScoreLbl.text = String(currentHighScore)
            
            } else {
                yourCurrentScoreLbl.isHidden = true
                currentHighScoreLbl.isHidden = true
                shareScoreBtn.isHidden = true
            }
            
    }
    
    
    @IBOutlet weak var yourCurrentScoreLbl: UILabel!
    @IBOutlet weak var currentHighScoreLbl: UILabel!
    @IBOutlet weak var shareScoreBtn: Buttons!
    @IBAction func shareScorePressed(_ sender: Buttons) {
        
        let score = UserDefaults.standard.object(forKey: "score")
        
        if let scoreToShare = score as? Int {
            // text to share
            let text = "My high score on Comic-Quiz.com is \(String(scoreToShare))!"
        
        // set up activity view controller
        let objectsToShare: [AnyObject] = [ text as AnyObject ]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
            
        }
    }
}
