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

    var answerSelected = ""
    var correctAnswer = ""
    var count = 1
    var pointsEarned = 0
    
    var correctAns = 0
    var incorrectAns = 0
    
    var easyColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple"]
    var medColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "Indigo", "Violet", "Black"]
    var hardColor:[String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "Indigo", "Violet", "Black", "Cyan", "Royal Blue", "Magenta", "Peach", "Tan", "Turquoise"]
    var colorBank:[String] = []
    
    var totWidth = 0
    var totHeight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        buttonDisp.backgroundColor = bgColor
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
        roundLab.textColor = fontColor
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
        button2 = UIButton(frame: CGRect(x: totWidth/2,y: 0, width: totWidth/2, height: totHeight/2))
        buttonDisp.addSubview(button2)
        button3 = UIButton(frame: CGRect(x: 0,y: totHeight/2, width: totWidth/2, height: totHeight/2))
        button4 = UIButton(frame: CGRect(x: totWidth/2,y: totHeight/2, width: totWidth/2, height: totHeight/2))
        for i in 1...4{
            getButton(pos: i).contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            getButton(pos: i).contentVerticalAlignment = UIControlContentVerticalAlignment.center
            getButton(pos: i).setTitleColor(fontColor, for: UIControlState())
            getButton(pos: i).layer.borderWidth = 2.0
            getButton(pos: i).layer.borderColor = bgColor.cgColor
            getButton(pos: i).backgroundColor = bgColor
            getButton(pos: i).layer.cornerRadius = 5.0
            getButton(pos: i).addTarget(self, action: #selector(ColorGame.doButtonStuff(_:)),
                              for: UIControlEvents.touchUpInside)
            buttonDisp.addSubview(getButton(pos: i))
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if(count <= gameburst){
            for i in 1...4{
                getButton(pos: i).isEnabled = true
            }
            timerLab.text = ""
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
        for i in 1...4{
            getButton(pos: i).isEnabled = false
        }
        nextButton.isHidden = false
        nextButton.titleLabel?.textColor = fontColor
    }
    
    func playNTC(){
        roundLab.text = "Round " + count.description
        var colorNames:[String] = randomSelColor()
        let correctAnswerPos = randomGen(range: colorNames.count)
        correctAnswer = colorNames[correctAnswerPos]
        colorWordDisp.backgroundColor = getColor(color: colorNames[correctAnswerPos])
        for i in 1...4{
            getButton(pos: i).setTitle(colorNames[i-1], for: .normal)
            getButton(pos: i).layer.borderColor = bgColor.cgColor
        }
        count += 1
    }
    
    func playITWC(){
        roundLab.text = "Round " + count.description
        var colorNames:[String] = randomSelColor()
        let correctAnswerPos = randomGen(range: colorNames.count)
        correctAnswer = colorNames[correctAnswerPos]
        colorWordText.text = correctAnswer
        colorWordText.textColor = getColor(color: "")
        for i in 1...4{
            getButton(pos: i).setTitle(colorNames[i-1], for: .normal)
            getButton(pos: i).setTitleColor(getColor(color: colorNames[i-1]), for: .normal)
            getButton(pos: i).layer.borderColor = bgColor.cgColor
            getButton(pos: i).backgroundColor = getColor(color: colorNames[i-1])
        }
        count += 1
    }
    
    func playNTFC(){
        roundLab.text = "Round " + count.description
        var colorNames:[String] = randomSelColor()
        let correctAnswerPos = randomGen(range: colorNames.count)
        correctAnswer = colorNames[correctAnswerPos]
        colorWordText.text = colorNames[randomGen(range: colorNames.count)]
        colorWordText.textColor = getColor(color: colorNames[correctAnswerPos])
        for i in 1...4{
            getButton(pos: i).setTitle(colorNames[i-1], for: .normal)
            getButton(pos: i).layer.borderColor = bgColor.cgColor
        }
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
        for i in 1...4{
            getButton(pos: i).setTitle(colorNames[i-1], for: .normal)
            getButton(pos: i).layer.borderColor = bgColor.cgColor
        }
        count += 1
    }
    
    @IBAction func pause(_ sender: Any) {
        
    }
    
    func getButton(pos:Int)->UIButton{
        switch(pos){
        case 1:
            return button1
        case 2:
            return button2
        case 3:
            return button3
        default:
            return button4
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
            correctAns += 1
            return true
        }
        else{
            pointsEarned += incorrect[selectScorePos()]
            incorrectAns += 1
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coltopvsegue" {
            if let toViewController = segue.destination as? PointsView {
                toViewController.pointsEarned = pointsEarned
                toViewController.corrAns = correctAns
                toViewController.incorrAns = incorrectAns
            }
        }
    }
    
}
