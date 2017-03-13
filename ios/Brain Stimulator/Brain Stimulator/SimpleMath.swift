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
    @IBOutlet var pauseOverlayDisp: UIView!
    
    var correctAns = 0
    var incorrectAns = 0
    
    var mixed = false
    
    var easyRangeEnd = 10
    var mediumRangeEnd = 15
    var hardRangeEnd = 30
    var rangeEnd = 12
    
    var answerSelected = ""
    var correctAnswer = ""
    var count = 1
    var pointsEarned = 0
    
    var totWidth = 0
    var totHeight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonDisp.backgroundColor = bgColor
        self.view.backgroundColor = bgColor
        pauseOverlayDisp.isHidden = true
        pauseOverlayDisp.backgroundColor = bgColor
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
            case "Addition":
                additionGame()
                break
            case "Subtraction":
                subtraction()
                break
            case "Multiplication":
                multiplication()
                break
            case "Division":
                division()
                break
            case "Square":
                square()
                break
            case "Square Root":
                sqroot()
                break
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
        nextButton.titleLabel?.textColor = fontColor
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
        pauseOverlayDisp.isHidden = false
        let w = Int(pauseOverlayDisp.frame.size.width)
        let h = Int(pauseOverlayDisp.frame.size.height)
        let continueButton = UIButton(frame: CGRect(x: 0, y: 0, width: w, height: h/2))
        continueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        continueButton.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        continueButton.setTitle("Continue", for: .normal)
        continueButton.layer.borderWidth = 2.0
        continueButton.backgroundColor = getColor(color: "Dark Green")
        continueButton.setTitleColor(fontColor, for: UIControlState())
        continueButton.titleLabel?.font = continueButton.titleLabel?.font.withSize(30)
        continueButton.addTarget(self, action: #selector(SimpleMath.cont),
                                 for: UIControlEvents.touchUpInside)
        pauseOverlayDisp.addSubview(continueButton)
        let quitButton = UIButton(frame: CGRect(x: 0, y: h/2, width: w, height: h/2))
        quitButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        quitButton.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        quitButton.setTitle("Leave", for: .normal)
        quitButton.layer.borderWidth = 2.0
        quitButton.backgroundColor = getColor(color: "Dark Red")
        quitButton.setTitleColor(fontColor, for: UIControlState())
        quitButton.titleLabel?.font = quitButton.titleLabel?.font.withSize(30)
        quitButton.addTarget(self, action: #selector(SimpleMath.quit),
                             for: UIControlEvents.touchUpInside)
        pauseOverlayDisp.addSubview(quitButton)
    }
    
    func cont(){
        pauseOverlayDisp.isHidden = true
    }
    
    func quit(){
        self.performSegue(withIdentifier: "smtopvsegue", sender: nil)
    }
    
    func additionGame(){
        roundLab.text = "Round " + count.description
        let t1 = randomGen(range: rangeEnd*2+1, start: -rangeEnd)
        let t2 = randomGen(range: rangeEnd*2+1, start: -rangeEnd)
        mathText.text = "(" + String(t1) + ") + (" + String(t2) + ") = "
        correctAnswer = Int(t1+t2).description
        var buttPos:[Int] = [1,2,3,4]
        var w1 = 0
        var w2 = 0
        var w3 = 0
        repeat{
            w1 = randomGen(range: 20, start: Int(correctAnswer)!-10)
            w2 = randomGen(range: 20, start: Int(correctAnswer)!-10)
            w3 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == Int(correctAnswer)! || w2 == w1 || w2 == Int(correctAnswer)! || w3 == w2 || w3 == w1 || w3 == Int(correctAnswer)!)
        var answerOps:[Int] = [Int(correctAnswer)!, w1, w2, w3]
        var a1 = 0
        while(buttPos.count != 0){
            let p = randomGen(range: buttPos.count)
            getButton(pos: buttPos[p]).setTitle(String(answerOps[a1]), for: .normal)
            getButton(pos: buttPos[p]).backgroundColor = bgColor
            getButton(pos: buttPos[p]).layer.borderColor = bgColor.cgColor
            buttPos.remove(at: p)
            a1 += 1
        }
        count += 1
    }
    
    func subtraction(){
        roundLab.text = "Round " + count.description
        let t1 = randomGen(range: rangeEnd*2+1, start: -rangeEnd)
        let t2 = randomGen(range: rangeEnd*2+1, start: -rangeEnd)
        mathText.text = "(" + String(t1) + ") - (" + String(t2) + ") = "
        correctAnswer = Int(t1-t2).description
        var buttPos:[Int] = [1,2,3,4]
        var w1 = 0
        var w2 = 0
        var w3 = 0
        repeat{
            w1 = randomGen(range: 20, start: Int(correctAnswer)!-10)
            w2 = randomGen(range: 20, start: Int(correctAnswer)!-10)
            w3 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == Int(correctAnswer)! || w2 == w1 || w2 == Int(correctAnswer)! || w3 == w2 || w3 == w1 || w3 == Int(correctAnswer)!)
        var answerOps:[Int] = [Int(correctAnswer)!, w1, w2, w3]
        var a1 = 0
        while(buttPos.count != 0){
            let p = randomGen(range: buttPos.count)
            getButton(pos: buttPos[p]).setTitle(String(answerOps[a1]), for: .normal)
            getButton(pos: buttPos[p]).backgroundColor = bgColor
            getButton(pos: buttPos[p]).layer.borderColor = bgColor.cgColor
            buttPos.remove(at: p)
            a1 += 1
        }
        count += 1
    }
    
    func multiplication(){
        roundLab.text = "Round " + count.description
        let t1 = randomGen(range: rangeEnd*2+1, start: -rangeEnd)
        let t2 = randomGen(range: rangeEnd*2+1, start: -rangeEnd)
        mathText.text = "(" + String(t1) + ") x (" + String(t2) + ") = "
        correctAnswer = Int(t1*t2).description
        var buttPos:[Int] = [1,2,3,4]
        var w1 = 0
        var w2 = 0
        var w3 = 0
        repeat{
            w1 = randomGen(range: 20, start: Int(correctAnswer)!-10)
            w2 = randomGen(range: 20, start: Int(correctAnswer)!-10)
            w3 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == Int(correctAnswer)! || w2 == w1 || w2 == Int(correctAnswer)! || w3 == w2 || w3 == w1 || w3 == Int(correctAnswer)!)
        var answerOps:[Int] = [Int(correctAnswer)!, w1, w2, w3]
        var a1 = 0
        while(buttPos.count != 0){
            let p = randomGen(range: buttPos.count)
            getButton(pos: buttPos[p]).setTitle(String(answerOps[a1]), for: .normal)
            getButton(pos: buttPos[p]).backgroundColor = bgColor
            getButton(pos: buttPos[p]).layer.borderColor = bgColor.cgColor
            buttPos.remove(at: p)
            a1 += 1
        }
        count += 1
    }
    
    func division(){
        roundLab.text = "Round " + count.description
        let t1 = randomGen(range: rangeEnd*2+1, start: -rangeEnd)
        var t2 = 0
        repeat{
            t2 = randomGen(range: rangeEnd*2+1, start: -rangeEnd)
        }while(t2 == 0 || t1%t2 != 0 || (t2>t1 && t1 != 0))
        mathText.text = "(" + String(t1) + ") / (" + String(t2) + ") = "
        correctAnswer = Int(t1/t2).description
        var buttPos:[Int] = [1,2,3,4]
        var w1 = 0
        var w2 = 0
        var w3 = 0
        repeat{
            w1 = randomGen(range: 20, start: Int(correctAnswer)!-10)
            w2 = randomGen(range: 20, start: Int(correctAnswer)!-10)
            w3 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == Int(correctAnswer)! || w2 == w1 || w2 == Int(correctAnswer)! || w3 == w2 || w3 == w1 || w3 == Int(correctAnswer)!)
        var answerOps:[Int] = [Int(correctAnswer)!, w1, w2, w3]
        var a1 = 0
        while(buttPos.count != 0){
            let p = randomGen(range: buttPos.count)
            getButton(pos: buttPos[p]).setTitle(String(answerOps[a1]), for: .normal)
            getButton(pos: buttPos[p]).backgroundColor = bgColor
            getButton(pos: buttPos[p]).layer.borderColor = bgColor.cgColor
            buttPos.remove(at: p)
            a1 += 1
        }
        count += 1
    }
    
    func square(){
        roundLab.text = "Round " + count.description
        let t1 = randomGen(range: rangeEnd*2+1, start: -rangeEnd)
        mathText.text = "(" + String(t1) + ")² = "
        correctAnswer = Int(t1*t1).description
        var buttPos:[Int] = [1,2,3,4]
        var w1 = 0
        var w2 = 0
        var w3 = 0
        repeat{
            w1 = randomGen(range: 20, start: Int(correctAnswer)!-10)
            w2 = randomGen(range: 20, start: Int(correctAnswer)!-10)
            w3 = randomGen(range: 20, start: Int(correctAnswer)!-10)
        }while(w1 == Int(correctAnswer)! || w2 == w1 || w2 == Int(correctAnswer)! || w3 == w2 || w3 == w1 || w3 == Int(correctAnswer)!)
        var answerOps:[Int] = [Int(correctAnswer)!, w1, w2, w3]
        var a1 = 0
        while(buttPos.count != 0){
            let p = randomGen(range: buttPos.count)
            getButton(pos: buttPos[p]).setTitle(String(answerOps[a1]), for: .normal)
            getButton(pos: buttPos[p]).backgroundColor = bgColor
            getButton(pos: buttPos[p]).layer.borderColor = bgColor.cgColor
            buttPos.remove(at: p)
            a1 += 1
        }
        count += 1
    }
    
    func sqroot(){
        roundLab.text = "Round " + count.description
        let t1 = randomGen(range: rangeEnd*2+1, start: -rangeEnd)
        mathText.text = "√(" + String(t1*t1) + ") = "
        correctAnswer = Int(sqrt(Double(t1*t1))).description
        var buttPos:[Int] = [1,2,3,4]
        var w1 = 0
        var w2 = 0
        var w3 = 0
        repeat{
            w1 = abs(randomGen(range: 20, start: Int(correctAnswer)!-10))
            w2 = abs(randomGen(range: 20, start: Int(correctAnswer)!-10))
            w3 = abs(randomGen(range: 20, start: Int(correctAnswer)!-10))
        }while(w1 == Int(correctAnswer)! || w2 == w1 || w2 == Int(correctAnswer)! || w3 == w2 || w3 == w1 || w3 == Int(correctAnswer)!)
        var answerOps:[Int] = [Int(correctAnswer)!, w1, w2, w3]
        var a1 = 0
        while(buttPos.count != 0){
            let p = randomGen(range: buttPos.count)
            getButton(pos: buttPos[p]).setTitle(String(answerOps[a1]), for: .normal)
            getButton(pos: buttPos[p]).backgroundColor = bgColor
            getButton(pos: buttPos[p]).layer.borderColor = bgColor.cgColor
            buttPos.remove(at: p)
            a1 += 1
        }
        count += 1
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if(count <= gameburst){
            for i in 1...4{
                getButton(pos: i).isEnabled = true
                getButton(pos: i).layer.borderColor = getColor(color: "").cgColor
            }
            timerLab.text = ""
            nextButton.isHidden = true
            playGameType()
        }
        else{
            self.performSegue(withIdentifier: "smtopvsegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "smtopvsegue" {
            if let toViewController = segue.destination as? PointsView {
                toViewController.pointsEarned = pointsEarned
                toViewController.corrAns = correctAns
                toViewController.incorrAns = incorrectAns
            }
        }
    }
    
}
