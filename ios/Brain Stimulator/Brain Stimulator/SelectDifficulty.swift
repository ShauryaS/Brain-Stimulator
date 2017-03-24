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
    
    var buttonHeight = 0
    
    @IBOutlet var scroll: UIScrollView!
    
    let diff:[String] = ["Easy", "Medium", "Hard"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        self.navigationController?.isNavigationBarHidden = false
        width = Int(UIScreen.main.bounds.width)
        height = Int(UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.size.height)!)
        buttonHeight = Int(height/3)
        scroll.contentSize.height = CGFloat(buttonHeight*3)
        navigationItem.title = "Select Difficulty"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setButtons()
    }
    
    func setButtons(){
        scroll.contentInset = UIEdgeInsets.zero
        for i in 1...3{
            let button = UIButton(frame: CGRect(x: 0, y: (i-1)*buttonHeight, width: width, height: buttonHeight))
            button.titleLabel!.font = button.titleLabel!.font.withSize(20)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            button.contentVerticalAlignment = UIControlContentVerticalAlignment.center
            button.layer.cornerRadius = 10.0
            button.backgroundColor = bgColor
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
            button.setTitleColor(fontColor, for: UIControlState())
            button.setTitle(diff[i-1], for: UIControlState())
            button.addTarget(self, action: #selector(SelectMode.buttonClicked(_:)),
                             for: UIControlEvents.touchUpInside)
            scroll.addSubview(button)
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
