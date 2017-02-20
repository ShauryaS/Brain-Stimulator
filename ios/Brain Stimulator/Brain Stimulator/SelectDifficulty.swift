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
    
    func getSpecifiedSegue()->String{
        gamesPlayed += 1
        firebaseRef.child("users").child(uid).updateChildValues(["gamesPlayed": gamesPlayed])
        switch(game){
            case "Simple Math":
                return "difftosmsegue"
            case "Complex Math":
                return "difftocmsegue"
            case "Memory":
                return "difftomemorysegue"
            case "Find It":
                return "difftofinditsegue"
            case "Colors":
                return "difftocolorsegue"
            default:
                return ""
        }
    }
    
    @IBAction func selEasy(_ sender: Any) {
        gameDifficulty = "Easy"
        self.performSegue(withIdentifier: getSpecifiedSegue(), sender: nil)
    }
    
    @IBAction func selMedium(_ sender: Any) {
        gameDifficulty = "Medium"
        self.performSegue(withIdentifier: getSpecifiedSegue(), sender: nil)
    }
    
    @IBAction func selHard(_ sender: Any) {
        gameDifficulty = "Hard"
        self.performSegue(withIdentifier: getSpecifiedSegue(), sender: nil)
    }
    
}
