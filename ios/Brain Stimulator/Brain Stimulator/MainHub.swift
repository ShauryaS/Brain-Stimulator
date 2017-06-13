//
//  MainHub.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 10/25/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

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
        if loggedIn == true{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(rightBarStuff))
            setStuff()
        }
        if loggedIn == false{
            self.navigationItem.title = "Client"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log In", style: .plain, target: self, action: #selector(rightBarStuff))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Join", style: .plain, target: self, action: #selector(leftBarStuff))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = bgColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: fontColor]
        self.view.backgroundColor = bgColor
        let sharedApp = UIApplication.shared
        sharedApp.delegate?.window??.tintColor = tintColor
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
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
            let button = UIButton(frame: CGRect(x:0, y:0, width:100, height: 40))
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            button.contentVerticalAlignment = UIControlContentVerticalAlignment.center
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.setTitle(username, for: .normal)
            button.addTarget(self, action: #selector(Mainhub.goToProfile(_:)), for: UIControlEvents.touchUpInside)
            self.navigationItem.titleView = button
        })
        firebaseRef.child("users").child(uid).child("points").observeSingleEvent(of: .value, with: {
            snapshot in
            points = snapshot.value as! Int
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: String(points), style: .plain, target: self, action: nil)
            self.navigationItem.leftBarButtonItem?.isEnabled = false
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
    
    func rightBarStuff(){
        if navigationItem.rightBarButtonItem?.title == "Log In"{
            self.performSegue(withIdentifier: "maintologsegue", sender: nil)
        }
        if navigationItem.rightBarButtonItem?.title == "Log Out"{
            username = ""
            email = ""
            pswd = ""
            uid = ""
            loggedIn = false
            removeSavedData(fileName: "savedData.txt")
            try! FIRAuth.auth()!.signOut()
            self.performSegue(withIdentifier: "logoutseg", sender: nil)
        }
    }
    
    func leftBarStuff(){
        if navigationItem.leftBarButtonItem?.title == "Join"{
            self.performSegue(withIdentifier: "maintocreateseg", sender: nil)
        }
    }
    
    func removeSavedData(fileName:String){
        let filePath = getDocumentsDirectory().appending("/"+fileName)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            do {
                try fileManager.removeItem(atPath: filePath)
            }
            catch let error as NSError {
                print("Error: "+"\(error)")
            }
        }
    }
    
    func goToProfile(_ sender: UIButton){
        self.performSegue(withIdentifier: "maintoprofsegue", sender: nil)
    }
    
}
