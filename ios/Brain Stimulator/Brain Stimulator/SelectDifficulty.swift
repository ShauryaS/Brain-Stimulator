//
//  SelectDifficulty.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 11/15/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class SelectDifficulty: UIViewController{
    
    var width = 0
    var height = 0
    
    let diff:[String] = ["Easy", "Medium", "Hard"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        self.navigationController?.isNavigationBarHidden = false
        width = Int(UIScreen.main.bounds.width)
        height = Int(UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.size.height)!)
        navigationItem.title = "Select Difficulty"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setButtons()
    }
    
    func setButtons(){
        for i in 1...3{
            let button = UIButton(frame: CGRect(x: 0, y: Int((self.navigationController?.navigationBar.frame.size.height)!)+(i-1)*height/3, width: width, height: height/3))
            button.titleLabel!.font = button.titleLabel!.font.withSize(20)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            button.contentVerticalAlignment = UIControlContentVerticalAlignment.center
            button.setTitleColor(fontColor, for: UIControlState())
            button.setTitle(diff[i-1], for: UIControlState())
            button.addTarget(self, action: #selector(SelectMode.buttonClicked(_:)),
                             for: UIControlEvents.touchUpInside)
            self.view.addSubview(button)
        }
    }
    
    func buttonClicked(_ sender:UIButton){
        gameDifficulty = (sender.titleLabel?.text!)!
        self.performSegue(withIdentifier: getSpecifiedSegue(), sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSpecifiedSegue()->String{
        gamesPlayed += 1
        firebaseRef.child("users").child(uid).updateChildValues(["gamesPlayed": gamesPlayed])
        switch(game){
            case "Simple Math":
                return "difftosmsegue"
            case "Complex Math":
                return "difftocmsegue"
            case "Memory":
                return "difftomemorysegue"
            case "Find It":
                return "difftofinditsegue"
            case "Colors":
                return "difftocolorsegue"
            default:
                return ""
        }
    }
    
}
