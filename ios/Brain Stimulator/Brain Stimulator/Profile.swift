//
//  Profile.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 6/12/17.
//  Copyright © 2017 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Profile: UIViewController{
    
    @IBOutlet var userLab: UILabel!
    @IBOutlet var typeLab: UILabel!
    @IBOutlet var pointsLab: UILabel!
    @IBOutlet var gamesPlayedLab: UILabel!
    @IBOutlet var daysLab: UILabel!
    @IBOutlet var burstLab: UILabel!
    @IBOutlet var burstTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLab.text = username
        if isTherapist == true{
            typeLab.text = "Account Type: Therapist"
        }
        else{
            typeLab.text = "Account Type: Client"
        }
        pointsLab.text = "Points: " + String(points)
        gamesPlayedLab.text = "Games Played: " + String(gamesPlayed)
        //daysLab.text = "Days Played: " + String(days)
        burstLab.text = "Burst: "
        self.view.backgroundColor = bgColor
        navigationItem.title = "Profile"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogIn.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userLab.textColor = fontColor
        typeLab.textColor = fontColor
        pointsLab.textColor = fontColor
        gamesPlayedLab.textColor = fontColor
        daysLab.textColor = fontColor
        burstLab.textColor = fontColor
        burstTF.textColor = fontColor
        burstTF.attributedPlaceholder = NSAttributedString(string:String(gameburst), attributes:[NSForegroundColorAttributeName: fontColor])
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settomainseg" {
            firebaseRef.child("users").child(uid).updateChildValues(["gameBurst": Int(burstTF.text!) ?? gameburst])
        }
    }
    
}

