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
    var complexMathModes:[String] = []
    var memoryModes:[String] = []
    var directionModes:[String] = []
    var findItModes:[String] = []
    var simpleMathModes:[String] = []
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Select Mode"
        scroll.contentSize.height = 40
        getGameModeOps()
        addButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addButtons(){
        for mode in options{
            let button = UIButton(frame: CGRect(x: 0,y: -50+(CGFloat(self.count))*35,width: 450,height: 25))
            button.titleLabel!.font = button.titleLabel!.font.withSize(18)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
            button.setTitleColor(UIColor.black, for: UIControlState())
            button.setTitle(mode, for: UIControlState())
            button.addTarget(self, action: #selector(SelectMode.buttonClicked(_:)),
                             for: UIControlEvents.touchUpInside)
            self.scroll.addSubview(button)
            if (5+CGFloat(self.count)+1)*35>self.scroll.contentSize.height{
                self.scroll.contentSize.height+=40
            }
            self.count=self.count+1
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
