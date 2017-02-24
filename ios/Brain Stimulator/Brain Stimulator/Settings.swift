//
//  Settings.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 11/13/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Settings: UIViewController{
    
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
        daysLab.text = "Days Played: " + String(days)
        burstLab.text = "Burst: "
        burstTF.placeholder = String(gameburst)
        self.view.backgroundColor = bgColor
        navigationItem.title = "Settings"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogIn.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    @IBAction func logout(_ sender: Any) {
        username = ""
        email = ""
        pswd = ""
        uid = ""
        let filePath = getDocumentsDirectory().appending("/savedData.txt")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            do {
                try fileManager.removeItem(atPath: filePath)
            }
            catch let error as NSError {
                print("Error: "+"\(error)")
            }
        }
        try! FIRAuth.auth()!.signOut()
        self.performSegue(withIdentifier: "backToLogInSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settomainseg" {
            firebaseRef.child("users").child(uid).updateChildValues(["gameBurst": Int(burstTF.text!) ?? gameburst])
        }
    }

}
