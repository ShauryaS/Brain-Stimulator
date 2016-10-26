//
//  Login.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 10/23/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class LogIn: UIViewController{
    
    @IBOutlet var titleLab: UILabel!
    @IBOutlet var rememberMeButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var useremailField: UITextField!
    @IBOutlet var pswdField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewColor()
        assignbackground()
        let sharedApp = UIApplication.shared
        sharedApp.delegate?.window??.tintColor = fontColor
        if bgColor != UIColor.white{
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogIn.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setViewColor(){
        self.view.backgroundColor = bgColor
        self.titleLab.textColor = fontColor
        rememberMeButton.setTitleColor(fontColor, for: UIControlState.normal)
        loginButton.setTitleColor(fontColor, for: UIControlState.normal)
        signupButton.setTitleColor(fontColor, for: UIControlState.normal)
    }
    
    func assignbackground(){
        let background = UIImage(named: "Brain.png")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }

    @IBAction func logIn(_ sender: AnyObject) {
        let useremail = useremailField.text!
        let pswd = pswdField.text!
        remembered = rememberMeButton.isSelected
        
    }
    
    @IBAction func remembermeTriggered(_ sender: AnyObject) {
        rememberMeButton.isSelected = !rememberMeButton.isSelected
    }

}
