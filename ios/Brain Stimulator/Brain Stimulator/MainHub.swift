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
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        self.navigationController?.isNavigationBarHidden = false
        setWelLab()
        setButtons()
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setWelLab(){
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
    }
    
    func setButtons(){
        button1.backgroundColor = bgColor
        button1.titleLabel?.textColor = fontColor
        button2.backgroundColor = bgColor
        button2.titleLabel?.textColor = fontColor
        button3.backgroundColor = bgColor
        button3.titleLabel?.textColor = fontColor
        button4.backgroundColor = bgColor
        button4.titleLabel?.textColor = fontColor
        button5.backgroundColor = bgColor
        button5.titleLabel?.textColor = fontColor
        button6.backgroundColor = bgColor
        button6.titleLabel?.textColor = fontColor
    }
    
    @IBAction func transSM(_ sender: UIButton) {
        game = (sender.titleLabel?.text!)!
        self.performSegue(withIdentifier: "maintomodesegue", sender: nil)
    }
    
    @IBAction func transColors(_ sender: UIButton) {
        game = (sender.titleLabel?.text!)!
        self.performSegue(withIdentifier: "maintomodesegue", sender: nil)
    }
    
    @IBAction func transCM(_ sender: UIButton) {
        game = (sender.titleLabel?.text!)!
        self.performSegue(withIdentifier: "maintomodesegue", sender: nil)
    }
    
    @IBAction func transMem(_ sender: UIButton) {
        game = (sender.titleLabel?.text!)!
        self.performSegue(withIdentifier: "maintomodesegue", sender: nil)
    }
    
    @IBAction func transFind(_ sender: UIButton) {
        game = (sender.titleLabel?.text!)!
        self.performSegue(withIdentifier: "maintomodesegue", sender: nil)
    }
    
}
