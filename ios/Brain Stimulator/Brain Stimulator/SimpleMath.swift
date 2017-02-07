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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        timerLab.textColor = fontColor
        self.navigationController?.isNavigationBarHidden = true
        selectRangeEnd()
        addButtons()
        startGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGame(){
        switch(gameType){
            case "Addition":
                additionGame()
            default:
                break
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
    
    func addButtons(){
        let totWidth = buttonDisp.bounds.width
        let totHeight = buttonDisp.bounds.height
        button1 = UIButton(frame: CGRect(x: 0,y: 0, width: totWidth/2-2.5, height: totHeight/2-2.5))
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button1.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button1.setTitleColor(UIColor.black, for: UIControlState())
        button1.addTarget(self, action: #selector(SimpleMath.doButtonStuff(_:)),
                          for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button1)
        button2 = UIButton(frame: CGRect(x: totWidth/2+2.5,y: 0, width: totWidth/2-2.5, height: totHeight/2-2.5))
        button2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button2.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button2.setTitleColor(UIColor.black, for: UIControlState())
        button2.addTarget(self, action: #selector(SimpleMath.doButtonStuff(_:)),
                          for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button2)
        button3 = UIButton(frame: CGRect(x: 0,y: totHeight/2+2.5, width: totWidth/2-2.5, height: totHeight/2-2.5))
        button3.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button3.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button3.setTitleColor(UIColor.black, for: UIControlState())
        button3.addTarget(self, action: #selector(SimpleMath.doButtonStuff(_:)),
                          for: UIControlEvents.touchUpInside)
        buttonDisp.addSubview(button3)
        button4 = UIButton(frame: CGRect(x: totWidth/2+2.5,y: totHeight/2+2.5, width: totWidth/2-2.5, height: totHeight/2-2.5))
        button4.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button4.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button4.setTitleColor(UIColor.black, for: UIControlState())
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
    
    func randomGen(range:Int)->Int{
        return Int(arc4random_uniform(UInt32(range)))
    }
    
    @IBAction func pause(_ sender: Any) {
        
    }
    
    func additionGame(){
        
    }
    
}
