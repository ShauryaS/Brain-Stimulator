//
//  CreateAccount.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 10/25/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CreateAccount: UIViewController{
    
    @IBOutlet var titleLab: UILabel!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var paswdField: UITextField!
    @IBOutlet var confirmpswdField: UITextField!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //assignbackground()
        setViewColor()
        self.view.backgroundColor = bgColor
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
        createButton.setTitleColor(fontColor, for: UIControlState.normal)
        cancelButton.setTitleColor(fontColor, for: UIControlState.normal)
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
    
    @IBAction func create(_ sender: AnyObject) {
        let username = usernameField.text!
        let email = emailField.text!
        let pswd = paswdField.text!
        let conPswd = confirmpswdField.text!
        if username != "" && email != "" && pswd != "" && conPswd != ""{
            if pswd == conPswd{
                FIRAuth.auth()?.createUser(withEmail: email, password: pswd) { (user, error) in
                    if error == nil
                    {
                        FIRAuth.auth()?.signIn(withEmail: email, password: pswd) { (user, error) in
                            if error == nil{
                                let data = ["username": username]
                                firebaseRef.child("users").child((user?.uid)!).setValue(data)
                                print("success")
                            }
                            else{
                                print(error!)
                            }
                        }
                    }
                    else
                    {
                        print(error!)
                    }

                }
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Make sure passwords match.", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Enter All Credentials.", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        usernameField.text = ""
        emailField.text = ""
        paswdField.text = ""
        confirmpswdField.text = ""
        self.performSegue(withIdentifier: "createtologseg", sender: nil)
    }
    
}
