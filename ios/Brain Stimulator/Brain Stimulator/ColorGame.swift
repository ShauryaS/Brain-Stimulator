//
//  ColorGame.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 11/13/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class ColorGame: UIViewController{//make method that returns button with specific text//find out why button disp width is always 343 --> same no matter the actual size
    
    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    var button4: UIButton!
    @IBOutlet var colorWordDisp: UIView!
    @IBOutlet var colorWordText: UILabel!
    @IBOutlet var timerLab: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var roundLab: UILabel!
    @IBOutlet var buttonDisp: UIView!
    
    var mixed = false

    var answerSelected = ""
    var correctAnswer = ""
    var count = 1
    var pointsEarned = 0
    
    var easyColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple"]
    var medColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "Indigo", "Violet", "Black"]
    var hardColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "Indigo", "Violet", "Black", "Cyan", "Royal Blue", "Magenta", "Peach", "Tan", "Turquoise"]
    var colorBank:[String] = []
    
    var totWidth = 0
    var totHeight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        timerLab.textColor = fontColor
        self.navigationController?.isNavigationBarHidden = true
        selectColorBank()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        totWidth = Int(colorWordDisp.frame.size.width)
        print(totWidth)
        totHeight = Int(colorWordDisp.frame.size.height)
        print(totHeight)
        addButtons()
        startGame()
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
    
    func addButtons(){
        button1 = UIButton(frame: CGRect(x: 0,y: 0, width: totWidth/2, height: totHeight/2))
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button1.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button1.setTitleColor(UIColor.black, for: UIControlState())
        button1.layer.borderWidth = 2.0
        button1.layer.borderColor = UIColor.white.cgColor
        button1.layer.cornerRadius = 5.0
        button1.addTarget(self, action: #selector(ColorGame.doButtonStuff(_:)),
                         for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button1)
        button2 = UIButton(frame: CGRect(x: totWidth/2,y: 0, width: totWidth/2, height: totHeight/2))
        button2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button2.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button2.setTitleColor(UIColor.black, for: UIControlState())
        button2.layer.borderWidth = 2.0
        button2.layer.borderColor = UIColor.white.cgColor
        button2.layer.cornerRadius = 5.0
        button2.addTarget(self, action: #selector(ColorGame.doButtonStuff(_:)),
                          for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button2)
        button3 = UIButton(frame: CGRect(x: 0,y: totHeight/2, width: totWidth/2, height: totHeight/2))
        button3.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button3.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button3.setTitleColor(UIColor.black, for: UIControlState())
        button3.layer.borderWidth = 2.0
        button3.layer.borderColor = UIColor.white.cgColor
        button3.layer.cornerRadius = 5.0
        button3.addTarget(self, action: #selector(ColorGame.doButtonStuff(_:)),
                          for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button3)
        button4 = UIButton(frame: CGRect(x: totWidth/2,y: totHeight/2, width: totWidth/2, height: totHeight/2))
        button4.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button4.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button4.setTitleColor(UIColor.black, for: UIControlState())
        button4.layer.borderWidth = 2.0
        button4.layer.borderColor = UIColor.white.cgColor
        button4.layer.cornerRadius = 5.0
        button4.addTarget(self, action: #selector(ColorGame.doButtonStuff(_:)),
                          for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button4)
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if(count <= gameburst){
            button1.isEnabled = true
            button2.isEnabled = true
            button3.isEnabled = true
            button4.isEnabled = true
            timerLab.text = ""
            button1.backgroundColor = getColor(color: "")
            button2.backgroundColor = getColor(color: "")
            button3.backgroundColor = getColor(color: "")
            button4.backgroundColor = getColor(color: "")
            button1.layer.borderColor = getColor(color: "").cgColor
            button2.layer.borderColor = getColor(color: "").cgColor
            button3.layer.borderColor = getColor(color: "").cgColor
            button4.layer.borderColor = getColor(color: "").cgColor
            nextButton.isHidden = true
            playGameType()
        }
        else{
            self.performSegue(withIdentifier: "coltopvsegue", sender: nil)
        }
    }
    
    func doButtonStuff(_ sender: UIButton){
        answerSelected = (sender.titleLabel?.text!)!
        let corr = checkAnswer()
        if corr == true{
            timerLab.text = "Correct"
            sender.layer.borderColor = getColor(color: "Dark Green").cgColor
        }
        else{
            timerLab.text = "Incorrect"
            sender.layer.borderColor = getColor(color: "Dark Red").cgColor
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coltopvsegue" {
            if let toViewController = segue.destination as? PointsView {
                toViewController.pointsEarned = pointsEarned
            }
        }
    }
    
}
