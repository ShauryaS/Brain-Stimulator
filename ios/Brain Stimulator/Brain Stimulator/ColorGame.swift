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
    
    var answerPressed = false
    
    var tutorialInfo:[[String]] = [["Green", "Yellow", "Red", "Green", "Blue"],["Purple", "Purple", "Red", "Blue", "Orange"],["Red", "Purple", "Green", "Blue", "Red"]]
    var easyColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple"]
    var medColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "Indigo", "Violet", "Black"]
    var hardColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "Indigo", "Violet", "Black", "Cyan", "Royal Blue", "Magenta", "Peach", "Tan", "Turquoise"]
    var colorBank:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        timerLab.textColor = fontColor
        self.navigationController?.isNavigationBarHidden = true
        selectColorBank()
        startGame()
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
        var count = 1
        while(count <= gameburst){
            var colorNames:[String] = []
            for i in 1...4{
                var matched = false
                var num = 0
                repeat{
                    matched = false
                    num = randomGen(range: colorBank.count)
                    if colorNames.count != 0{
                        for names in colorNames{
                            if names == self.colorBank[num]{
                                matched = true
                            }
                        }
                    }
                }while(matched)
                colorNames.append(colorBank[num])
            }
            //pause thread and resume when button pressed
            let correctAnswerPos = randomGen(range: colorNames.count)
            colorWordDisp.backgroundColor = getColor(color: colorNames[correctAnswerPos])
            let correctAnswer = colorBank[correctAnswerPos]
            button1.setTitle(colorNames[0], for: .normal)
            button2.setTitle(colorNames[1], for: .normal)
            button3.setTitle(colorNames[2], for: .normal)
            button4.setTitle(colorNames[3], for: .normal)
        
            count += 1
       }
    }
    
    func playITWC(){
    
    }
    
    func playNTFC(){
        
    }
    
    func playFTDC(){
        
    }
    
    @IBAction func pause(_ sender: Any) {
        
    }
    
    func getColor(color:String) -> UIColor{
        switch(color){
            case "Red":
                return UIColor.red
            case "Orange":
                return UIColor.orange
            case "Yellow":
                return UIColor.yellow
            case "Green":
                return UIColor.green
            case "Blue":
                return UIColor.blue
            case "Purple":
                return UIColor.purple
            case "Brown":
                return UIColor.brown
            case "Gray":
                return UIColor.gray
            case "Indigo":
                return UIColor.init(red: 75, green: 0, blue: 130, alpha: 0)
            case "Violet":
                return UIColor.init(red: 238, green: 130, blue: 238, alpha: 0)
            case "Black":
                return UIColor.black
            case "Cyan":
                return UIColor.cyan
            case "Royal Blue":
                return UIColor.init(red: 65, green: 105, blue: 225, alpha: 0)
            case "Magenta":
                return UIColor.magenta
            case "Peach":
                return UIColor.init(red: 255, green: 218, blue: 185, alpha: 0)
            case "Tan":
                return UIColor.init(red: 210, green: 180, blue: 140, alpha: 0)
            case "Turquoise":
                return UIColor.init(red: 64, green: 224, blue: 208, alpha: 0)
            default:
                return UIColor.white
        }
    }
    
    func selectColorBank(){
        switch(gameDifficulty){
            case "Easy":
                colorBank = easyColor
                break
            case "Medium":
                colorBank = medColor
                break
            case "Hard":
                colorBank = hardColor
                break
            default:
                break
        }
    }
    
    func randomGen(range:Int)->Int{
        return Int(arc4random_uniform(UInt32(range)))
    }
    
}
