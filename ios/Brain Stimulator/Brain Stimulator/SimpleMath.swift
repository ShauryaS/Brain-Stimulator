//
//  SimpleMath.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 11/15/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class SimpleMath: UIViewController{
    
    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    var button4: UIButton!
    @IBOutlet var mathDisp: UIView!
    @IBOutlet var mathText: UILabel!
    @IBOutlet var timerLab: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var roundLab: UILabel!
    @IBOutlet var buttonDisp: UIView!
    
    var easyRangeEnd = 10
    var mediumRangeEnd = 15
    var hardRangeEnd = 20
    var rangeEnd = 12
    
    var answerSelected = ""
    var correctAnswer = ""
    var count = 1
    var pointsEarned = 0
    
    var totWidth = 0
    var totHeight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        timerLab.textColor = fontColor
        self.navigationController?.isNavigationBarHidden = true
        selectRangeEnd()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        totWidth = Int(buttonDisp.frame.size.width)
        totHeight = Int(buttonDisp.frame.size.height)
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
            case "Addition":
                additionGame()
            case "Multiplication":
                multiplication()
            case "Square":
                square()
            default:
                break
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
    
    func addButtons(){
        button1 = UIButton(frame: CGRect(x: 0,y: 0, width: totWidth/2, height: totHeight/2))
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button1.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button1.setTitleColor(UIColor.black, for: UIControlState())
        button1.layer.borderWidth = 2.0
        button1.layer.borderColor = UIColor.white.cgColor
        button1.layer.cornerRadius = 5.0
        button1.addTarget(self, action: #selector(SimpleMath.doButtonStuff(_:)),
                          for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button1)
        button2 = UIButton(frame: CGRect(x: totWidth/2,y: 0, width: totWidth/2, height: totHeight/2))
        button2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button2.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button2.setTitleColor(UIColor.black, for: UIControlState())
        button2.layer.borderWidth = 2.0
        button2.layer.borderColor = UIColor.white.cgColor
        button2.layer.cornerRadius = 5.0
        button2.addTarget(self, action: #selector(SimpleMath.doButtonStuff(_:)),
                          for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button2)
        button3 = UIButton(frame: CGRect(x: 0,y: totHeight/2, width: totWidth/2, height: totHeight/2))
        button3.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button3.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button3.setTitleColor(UIColor.black, for: UIControlState())
        button3.layer.borderWidth = 2.0
        button3.layer.borderColor = UIColor.white.cgColor
        button3.layer.cornerRadius = 5.0
        button3.addTarget(self, action: #selector(SimpleMath.doButtonStuff(_:)),
                          for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button3)
        button4 = UIButton(frame: CGRect(x: totWidth/2, y: totHeight/2, width: totWidth/2, height: totHeight/2))
        button4.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button4.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button4.setTitleColor(UIColor.black, for: UIControlState())
        button4.layer.borderWidth = 2.0
        button4.layer.borderColor = UIColor.white.cgColor
        button4.layer.cornerRadius = 5.0
        button4.addTarget(self, action: #selector(SimpleMath.doButtonStuff(_:)),
                          for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button4)
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
    
    func selectRangeEnd(){
        switch(gameDifficulty){
        case "Easy":
            rangeEnd = easyRangeEnd
            break
        case "Medium":
            rangeEnd = mediumRangeEnd
            break
        case "Hard":
            rangeEnd = hardRangeEnd
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
    
    func randomGen(range:Int)->Int{
        return Int(arc4random_uniform(UInt32(range)))
    }
    
    func randomGen(range:Int, start:Int)->Int{
        return Int(arc4random_uniform(UInt32(range)))+start
    }
    
    @IBAction func pause(_ sender: Any) {
        
    }
    
    func additionGame(){
        roundLab.text = "Round " + count.description
        let t1 = randomGen(range: rangeEnd+1)
        let t2 = randomGen(range: rangeEnd+1)
        mathText.text = String(t1) + " + " + String(t2) + " = "
        correctAnswer = Int(t1+t2).description
        var buttPos:[Int] = [1,2,3,4]
        var w1 = 0
        var w2 = 0
        var w3 = 0
        repeat{
            w1 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == Int(correctAnswer)!)
        repeat{
            w2 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == w2 && w2==Int(correctAnswer)!)
        repeat{
            w3 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w3 == w2 && w3 == w1 && w3 == Int(correctAnswer)!)
        var answerOps:[Int] = [Int(correctAnswer)!, w1, w2, w3]
        var a1 = 0
        while(buttPos.count != 0){
            let p = randomGen(range: buttPos.count)
            getButton(pos: buttPos[p]).setTitle(String(answerOps[a1]), for: .normal)
            buttPos.remove(at: p)
            a1 += 1
        }
        count += 1
    }
    
    func subtraction(){
        
    }
    
    func multiplication(){
        roundLab.text = "Round " + count.description
        let t1 = randomGen(range: rangeEnd+1)
        let t2 = randomGen(range: rangeEnd+1)
        mathText.text = String(t1) + " x " + String(t2) + " = "
        correctAnswer = Int(t1*t2).description
        var buttPos:[Int] = [1,2,3,4]
        var w1 = 0
        var w2 = 0
        var w3 = 0
        repeat{
            w1 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == Int(correctAnswer)!)
        repeat{
            w2 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == w2 && w2==Int(correctAnswer)!)
        repeat{
            w3 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w3 == w2 && w3 == w1 && w3 == Int(correctAnswer)!)
        var answerOps:[Int] = [Int(correctAnswer)!, w1, w2, w3]
        var a1 = 0
        while(buttPos.count != 0){
            let p = randomGen(range: buttPos.count)
            getButton(pos: buttPos[p]).setTitle(String(answerOps[a1]), for: .normal)
            buttPos.remove(at: p)
            a1 += 1
        }
        count += 1
    }
    
    func division(){
        
    }
    
    func square(){
        roundLab.text = "Round " + count.description
        let t1 = randomGen(range: rangeEnd+1)
        mathText.text = String(t1) + "^2 = "
        correctAnswer = Int(t1*t1).description
        var buttPos:[Int] = [1,2,3,4]
        var w1 = 0
        var w2 = 0
        var w3 = 0
        repeat{
            w1 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == Int(correctAnswer)!)
        repeat{
            w2 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == w2 || w2==Int(correctAnswer)!)
        repeat{
            w3 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w3 == w2 || w3 == w1 || w3 == Int(correctAnswer)!)
        var answerOps:[Int] = [Int(correctAnswer)!, w1, w2, w3]
        var a1 = 0
        while(buttPos.count != 0){
            let p = randomGen(range: buttPos.count)
            getButton(pos: buttPos[p]).setTitle(String(answerOps[a1]), for: .normal)
            buttPos.remove(at: p)
            a1 += 1
        }
        count += 1
    }
    
    func sqroot(){
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if(count <= gameburst){
            button1.isEnabled = true
            button2.isEnabled = true
            button3.isEnabled = true
            button4.isEnabled = true
            timerLab.text = ""
            button1.layer.borderColor = getColor(color: "").cgColor
            button2.layer.borderColor = getColor(color: "").cgColor
            button3.layer.borderColor = getColor(color: "").cgColor
            button4.layer.borderColor = getColor(color: "").cgColor
            nextButton.isHidden = true
            playGameType()
        }
        else{
            points += pointsEarned
            self.performSegue(withIdentifier: "smtopvsegue", sender: nil)
        }
    }
    
}
