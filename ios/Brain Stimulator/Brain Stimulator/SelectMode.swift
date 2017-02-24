//
//  SelectMode.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 11/15/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class SelectMode: UIViewController{
    
    @IBOutlet var scroll: UIScrollView!
    var options:[String] = []
    var colorModes:[String] = ["Name The Color", "Identify The Word Color", "Name The Font Color", "Name The Background Color"]
    var complexMathModes:[String] = ["Exponents", "PEMDAS", "Algebra Addition", "Algebra Subtraction", "Algebra Multiplication", "Algebra Division"]
    var memoryModes:[String] = []
    var directionModes:[String] = []
    var findItModes:[String] = []
    var simpleMathModes:[String] = ["Addition", "Subtraction", "Multiplication", "Division", "Square", "Square Root"]
    var count = 0
    
    let width = Int(UIScreen.main.bounds.width)
    var height = 0
    var buttonHeight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Select Mode"
        getGameModeOps()
        height = Int(UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.size.height)!)
        buttonHeight = Int(height/5)
        scroll.contentSize.height = CGFloat(buttonHeight*options.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addButtons()
    }
    
    func addButtons(){
        scroll.contentInset = UIEdgeInsets.zero
        for mode in options{
            let button = UIButton(frame: CGRect(x: 0,y: Int(CGFloat(buttonHeight) * (CGFloat(count))), width: width, height: buttonHeight))
            button.titleLabel!.font = button.titleLabel!.font.withSize(18)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            button.contentVerticalAlignment = UIControlContentVerticalAlignment.center
            button.setTitleColor(UIColor.black, for: UIControlState())
            button.setTitle(mode, for: UIControlState())
            button.addTarget(self, action: #selector(SelectMode.buttonClicked(_:)),
                             for: UIControlEvents.touchUpInside)
            self.scroll.addSubview(button)
            count+=1
        }
    }
    
    func buttonClicked(_ sender:UIButton){
        gameType = (sender.titleLabel?.text!)!
        print(gameType)
        self.performSegue(withIdentifier: "modetodifficultysegue", sender: nil)
    }
    
    func getGameModeOps(){
        switch(game){
            case "Colors":
                options = colorModes
                break
            case "Simple Math":
                options = simpleMathModes
                break
            case "Complex Math":
                options = complexMathModes
                break
            case "Find It":
                options = findItModes
                break
            case "Memory":
                options = memoryModes
                break
            case "Directions":
                options = directionModes
                break
            default:
                break
        }
    }
    
}
