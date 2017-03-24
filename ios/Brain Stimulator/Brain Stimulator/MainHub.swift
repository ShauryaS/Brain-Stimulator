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
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var buttonScroll: UIScrollView!
    var buttons:[UIButton] = []
    var gameNames:[String] = ["Colors", "Simple Math", "Complex Math", "Memory", "Directions", "Find It"]
    var patientNames:[String] = []
    let width = Int(UIScreen.main.bounds.width)
    var scrHeight = 0
    var buttonWidth = 0
    var buttonHeight = 0
    var alreadyEntered = false
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setStuff()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        UINavigationBar.appearance().barTintColor = bgColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: fontColor]
        self.view.backgroundColor = bgColor
        let sharedApp = UIApplication.shared
        sharedApp.delegate?.window??.tintColor = tintColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainLabel.textColor = fontColor
        scrHeight = Int(buttonScroll.bounds.height)
        buttonWidth = width/2
        buttonHeight = scrHeight/3
        buttonScroll.isScrollEnabled = true
        if alreadyEntered == false{
            addButtons()
            alreadyEntered = true
        }
        buttonScroll.contentSize.height = CGFloat(buttonHeight*buttons.count/2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setStuff(){
        firebaseRef.child("users").child(uid).child("name").observeSingleEvent(of: .value, with: {
            snapshot in
            username = snapshot.value as! String
            self.navigationItem.title = username
        })
        firebaseRef.child("users").child(uid).child("points").observeSingleEvent(of: .value, with: {
            snapshot in
            points = snapshot.value as! Int
        })
        firebaseRef.child("users").child(uid).child("gameBurst").observeSingleEvent(of: .value, with: {
            snapshot in
            gameburst = snapshot.value as! Int
        })
        firebaseRef.child("users").child(uid).child("gamesPlayed").observeSingleEvent(of: .value, with: {
            snapshot in
            gamesPlayed = snapshot.value as! Int
        })
        firebaseRef.child("users").child(uid).child("days").observeSingleEvent(of: .value, with: {
            snapshot in
            days = snapshot.value as! Int
        })
        firebaseRef.child("users").child(uid).child("isTherapist").observeSingleEvent(of: .value, with: {
            snapshot in
            isTherapist = snapshot.value as! Bool
        })
    }
    
    func addButtons(){
        var names:[String] = []
        if isTherapist == false{
            mainLabel.text = "Stimulation Games"
            names = gameNames
        }
        else{
            mainLabel.text = "Patients"
            names = patientNames
        }
        if names.count > 0{
            for i in 1...(names.count)/2{
                for j in 1...2{
                    let button = UIButton(frame: CGRect(x: (j-1)*buttonWidth,y: (i-1)*buttonHeight, width: buttonWidth, height: buttonHeight))
                    buttons.append(button)
                }
            }
            for b in 1...buttons.count{
                buttons[b-1].titleLabel!.font = buttons[b-1].titleLabel!.font.withSize(20)
                buttons[b-1].contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
                buttons[b-1].contentVerticalAlignment = UIControlContentVerticalAlignment.center
                buttons[b-1].setTitleColor(fontColor, for: UIControlState())
                buttons[b-1].setTitle(names[b-1], for: UIControlState())
                buttons[b-1].layer.cornerRadius = 10.0
                buttons[b-1].backgroundColor = bgColor
                buttons[b-1].layer.borderWidth = 1.0
                buttons[b-1].layer.borderColor = UIColor.black.cgColor
                buttons[b-1].titleLabel?.textColor = fontColor
                buttons[b-1].addTarget(self, action: #selector(Mainhub.buttonPressed(_:)),
                                       for: UIControlEvents.touchUpInside)
                buttonScroll.addSubview(buttons[b-1])
            }
        }
    }
    
    func buttonPressed(_ sender: UIButton){
        game = (sender.titleLabel?.text!)!
        if game == "Complex Math" || game == "Directions" || game == "Find It" || game == "Memory"{
            let alert = UIAlertController(title: "Locked", message: "Game Coming Soon.", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            self.performSegue(withIdentifier: "maintomodesegue", sender: nil)
        }
    }
    
}
