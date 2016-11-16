//
//  SelectDifficulty.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 11/15/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class SelectDifficulty: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Select Difficulty"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
