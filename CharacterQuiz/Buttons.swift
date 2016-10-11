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
        self.layer.shouldRasterize = true
    }

}
