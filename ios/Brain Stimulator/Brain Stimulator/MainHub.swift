//
//  MainHub.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 10/25/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class Mainhub: UIViewController{
    
    @IBOutlet var userWelLab: UILabel!
    @IBOutlet var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        settingsButton.setTitleColor(fontColor, for: UIControlState.normal)
        setWelLab()
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setWelLab(){
        userWelLab.textColor = fontColor
        firebaseRef.child("users").child(uid).child("username").observeSingleEvent(of: .value, with: {
            snapshot in
            username = snapshot.value as! String
            print(username)
            self.userWelLab.text = username + " hub"
        })
    }
    
}
