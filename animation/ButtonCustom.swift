//
//  ButtonCustom.swift
//  animation
//
//  Created by Oscar Daza on 9/17/19.
//  Copyright © 2019 Oscar Daza. All rights reserved.
//

import UIKit

class ButtonCustom: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.red
        self.tintColor = UIColor.white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
