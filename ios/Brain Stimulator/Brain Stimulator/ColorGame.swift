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
    @IBOutlet var colorWordText: UILabel!
    @IBOutlet var timerLab: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var roundLab: UILabel!

    var answerSelected = ""
    var correctAnswer = ""
    var count = 1
    var pointsEarned = 0
    
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
        answerSelected = ""
        correctAnswer = ""
        playGameType()
    }
    
    func playGameType(){
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
            case "Name The Background Color":
                playNTBC()
                break
            default:
                break
        }
    }
    
    @IBAction func b1Pressed(_ sender: UIButton) {
        doButtonStuff(sender)
    }
    
    @IBAction func b2Pressed(_ sender: UIButton) {
        doButtonStuff(sender)
    }
    
    @IBAction func b3Pressed(_ sender: UIButton) {
        doButtonStuff(sender)
    }
    
    @IBAction func b4Pressed(_ sender: UIButton) {
        doButtonStuff(sender)
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if(count <= gameburst){
            button1.isEnabled = true
            button2.isEnabled = true
            button3.isEnabled = true
            button4.isEnabled = true
            button1.backgroundColor = getColor(color: "")
            button2.backgroundColor = getColor(color: "")
            button3.backgroundColor = getColor(color: "")
            button4.backgroundColor = getColor(color: "")
            nextButton.isHidden = true
            playGameType()
        }
        else{
            points += pointsEarned
            self.performSegue(withIdentifier: "colortomainsegue", sender: nil)
        }
    }
    
    func doButtonStuff(_ sender: UIButton){
        answerSelected = (sender.titleLabel?.text!)!
        let corr = checkAnswer()
        if corr == true{
            sender.backgroundColor = getColor(color: "Green")
        }
        else{
            sender.backgroundColor = getColor(color: "Red")
        }
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        nextButton.isHidden = false
    }
    
    func playNTC(){
        roundLab.text = "Round " + count.description
        var colorNames:[String] = randomSelColor()
        let correctAnswerPos = randomGen(range: colorNames.count)
        colorWordDisp.backgroundColor = getColor(color: colorNames[correctAnswerPos])
        correctAnswer = colorNames[correctAnswerPos]
        button1.setTitle(colorNames[0], for: .normal)
        button2.setTitle(colorNames[1], for: .normal)
        button3.setTitle(colorNames[2], for: .normal)
        button4.setTitle(colorNames[3], for: .normal)
        count += 1
    }
    
    func playITWC(){
        roundLab.text = "Round " + count.description
        var colorNames:[String] = randomSelColor()
        let correctAnswerPos = randomGen(range: colorNames.count)
        correctAnswer = colorNames[correctAnswerPos]
        colorWordText.text = correctAnswer
        colorWordText.textColor = getColor(color: "Black")
        button1.setTitleColor(getColor(color: colorNames[0]), for: .normal)
        button1.backgroundColor = getColor(color: colorNames[0])
        button1.setTitle(colorNames[0], for: .normal)
        button2.setTitleColor(getColor(color: colorNames[1]), for: .normal)
        button2.backgroundColor = getColor(color: colorNames[1])
        button2.setTitle(colorNames[1], for: .normal)
        button3.setTitleColor(getColor(color: colorNames[2]), for: .normal)
        button3.backgroundColor = getColor(color: colorNames[2])
        button3.setTitle(colorNames[2], for: .normal)
        button4.setTitleColor(getColor(color: colorNames[3]), for: .normal)
        button4.backgroundColor = getColor(color: colorNames[3])
        button4.setTitle(colorNames[3], for: .normal)
        count += 1
    }
    
    func playNTFC(){
        roundLab.text = "Round " + count.description
        var colorNames:[String] = randomSelColor()
        let correctAnswerPos = randomGen(range: colorNames.count)
        correctAnswer = colorNames[correctAnswerPos]
        colorWordText.text = colorNames[randomGen(range: colorNames.count)]
        colorWordText.textColor = getColor(color: colorNames[correctAnswerPos])
        button1.setTitle(colorNames[0], for: .normal)
        button2.setTitle(colorNames[1], for: .normal)
        button3.setTitle(colorNames[2], for: .normal)
        button4.setTitle(colorNames[3], for: .normal)
        count += 1
    }
    
    func playNTBC(){
        roundLab.text = "Round " + count.description
        var colorNames:[String] = randomSelColor()
        let correctAnswerPos = randomGen(range: colorNames.count)
        correctAnswer = colorNames[correctAnswerPos]
        colorWordDisp.backgroundColor = getColor(color: colorNames[correctAnswerPos])
        colorWordText.backgroundColor = getColor(color: colorNames[correctAnswerPos])
        colorWordText.text = colorNames[randomGen(range: colorNames.count)]
        colorWordText.textColor = getColor(color: colorNames[randomGen(range: colorNames.count)])
        button1.setTitle(colorNames[0], for: .normal)
        button2.setTitle(colorNames[1], for: .normal)
        button3.setTitle(colorNames[2], for: .normal)
        button4.setTitle(colorNames[3], for: .normal)
        count += 1
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
                return UIColor.init(displayP3Red: 75.0/255.0, green: 0.0/255.0, blue: 130.0/255.0, alpha: 1.0)
            case "Violet":
                return UIColor.init(displayP3Red: 238.0/255.0, green: 130.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            case "Black":
                return UIColor.black
            case "Cyan":
                return UIColor.cyan
            case "Royal Blue":
                return UIColor.init(displayP3Red: 65.0/255.0, green: 105.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            case "Magenta":
                return UIColor.magenta
            case "Peach":
                return UIColor.init(displayP3Red: 255.0/255.0, green: 218.0/255.0, blue: 185.0/255.0, alpha: 1.0)
            case "Tan":
                return UIColor.init(displayP3Red: 210.0/255.0, green: 180.0/255.0, blue: 140.0/255.0, alpha: 1.0)
            case "Turquoise":
                return UIColor.init(displayP3Red: 64.0/255.0, green: 224.0/255.0, blue: 208.0/255.0, alpha: 1.0)
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
    
    func selectScorePos() -> Int{
        switch(gameDifficulty){
            case "Easy":
                return 0
            case "Medium":
                return 1
            case "Hard":
                return 2
            default:
                return 3
        }
    }
    
    func randomGen(range:Int)->Int{
        return Int(arc4random_uniform(UInt32(range)))
    }
    
    func randomSelColor()->[String]{
        var colors:[String] = []
        for i in 1...4{
            var matched = false
            var num = 0
            repeat{
                matched = false
                num = randomGen(range: colorBank.count)
                if colors.count != 0{
                    for names in colors{
                        if names == self.colorBank[num]{
                            matched = true
                        }
                    }
                }
            }while(matched)
            colors.append(colorBank[num])
        }
        return colors
    }
    
    func checkAnswer()->Bool{
        if answerSelected == correctAnswer {
            pointsEarned += correct[selectScorePos()]
            return true
        }
        else{
            pointsEarned += incorrect[selectScorePos()]
            return false
        }
    }
    
}
