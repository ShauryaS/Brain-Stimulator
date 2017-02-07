//
//  CheckBox.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 2/5/17.
//  Copyright © 2017 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class CheckBox: UIButton {//fix
    // Images
    let checkedImage = UIImage(named: "checkmarkselected")! as UIImage
    let uncheckedImage = UIImage(named: "checkmarkunselected")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: Selector(("buttonClicked:")), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
