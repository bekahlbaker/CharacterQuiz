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
        
    }
    @IBAction func shareScorePressed(_ sender: Buttons) {
        
        // text to share
        let text = "My high score is 20."
        
        // set up activity view controller
        let objectsToShare: [AnyObject] = [ text as AnyObject ]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}
