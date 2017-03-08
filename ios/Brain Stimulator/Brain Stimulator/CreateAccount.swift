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
    @IBOutlet var therapistCheck: UIButton!
    @IBOutlet var therapistLab: UILabel!
    var selected:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        setViewColor()
        self.navigationController?.isNavigationBarHidden = true
        selected = false
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
        therapistLab.textColor = fontColor
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
                                let data = ["name": username, "isTherapist": self.selected, "points": 0, "gamesPlayed": 0, "days": 0, "gameBurst": 10, "darkMode": darkMode] as [String : Any]
                                firebaseRef.child("users").child((user?.uid)!).setValue(data)
                                self.performSegue(withIdentifier: "createtologseg", sender: nil)
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
    
    @IBAction func checkBox(_ sender: Any) {
        selected = !selected
        if selected == true{
            therapistCheck.setImage(UIImage(named: "lightcheckfilled"), for: .normal)
        }
        else{
            therapistCheck.setImage(UIImage(named: "lighcheckunfilled"), for: .normal)
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
