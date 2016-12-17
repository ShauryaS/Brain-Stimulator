//
//  ColorGame.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 11/13/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class ColorGame: UIViewController{
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var colorWordDisp: UIView!
    @IBOutlet var timerLab: UILabel!
    
    var tutorialInfo:[[String]] = [["Green", "Yellow", "Red", "Green", "Blue"],["Purple", "Purple", "Red", "Blue", "Orange"],["Red", "Purple", "Green", "Blue", "Red"]]
    var easyColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple"]
    var medColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "White", "Indigo", "Violet", "Black"]
    var hardColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "White", "Indigo", "Violet", "Black", "Cyan", "Royal Blue", "Magenta", "Peach", "Tan", "Turquoise"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        timerLab.textColor = fontColor
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGame(){
        switch(gameType){
            case "Name The Color":
                playNTC()
                break
            case "Identify The Word Color":
                playITWC()
                break
            case "Name The Font Color":
                playNTFC()
                break
            case "Find the Different Color":
                playFTDC()
                break
            default:
                break
        }
    }
    
    func playNTC(){
        
    }
    
    func playITWC(){
    
    }
    
    func playNTFC(){
        
    }
    
    func playFTDC(){
        
    }
    
    @IBAction func pause(_ sender: Any) {
        
    }
    
}
