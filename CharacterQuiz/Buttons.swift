//
//  Buttons.swift
//  CharacterQuiz
//
//  Created by Rebekah Baker on 10/11/16.
//  Copyright © 2016 Rebekah Baker. All rights reserved.
//

import UIKit

class Buttons: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
//        self.layer.shouldRasterize = true
    }
    
    func incorrectButton () {
        
        setTitle("Try again!", for: .normal)
        backgroundColor = UIColor(red:0.97, green:0.02, blue:0.03, alpha:1.0)
    }
    
    func correctButton () {
        
        setTitle("Correct!", for: .normal)
        backgroundColor = UIColor(red:0.53, green:0.83, blue:0.49, alpha:1.0)
    }
    
    func normalButton () {
        
        setTitle("Submit", for: .normal)
        backgroundColor = UIColor(red:0, green:0, blue:0, alpha:1.0)
    }
    
    func skipButton () {
        
        setTitle("Skip", for: .normal)
        setTitleColor(UIColor(red:0, green:0, blue:0, alpha:1.0), for: .normal)
        backgroundColor = UIColor(red:1, green:1, blue:1, alpha:1.0)
    }
    
    func nextButton () {
        
        setTitle("Next", for: .normal)
        setTitleColor(UIColor(red:0, green:0, blue:0, alpha:1.0), for: .normal)
        backgroundColor = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
    }

}
