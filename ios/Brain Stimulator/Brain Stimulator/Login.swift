//
//  Login.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 10/23/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LogIn: UIViewController{
    
    @IBOutlet var titleLab: UILabel!
    @IBOutlet var rememberMeButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var useremailField: UITextField!
    @IBOutlet var pswdField: UITextField!
    @IBOutlet var rememberLab: UILabel!
    var selected:Bool = false
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        readAuthFile()
        if username != "" && pswd != ""{
            login(useremail: username, pswd: pswd)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewColor()
        let sharedApp = UIApplication.shared
        sharedApp.delegate?.window??.tintColor = fontColor
        self.navigationController?.isNavigationBarHidden = true
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
        cancelButton.setTitleColor(fontColor, for: UIControlState.normal)
        rememberLab.textColor = fontColor
    }

    @IBAction func logIn(_ sender: AnyObject) {
        let useremail = useremailField.text!
        let pswd = pswdField.text!
        remembered = selected
        login(useremail: useremail, pswd: pswd)
    }
    
    func login(useremail:String, pswd:String){
        if useremail != "" && pswd != ""{
            FIRAuth.auth()?.signIn(withEmail: useremail, password: pswd) { (user, error) in
                if error == nil{
                    if remembered != nil && remembered == true{
                        self.saveAuth(username: useremail, password: pswd)
                    }
                    uid = (user?.uid)!
                    loggedIn = true
                    self.performSegue(withIdentifier: "logtohubseg", sender: nil)
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "Sign In Failed.", preferredStyle: UIAlertControllerStyle.alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Enter All Credentials.", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.performSegue(withIdentifier: "logtohubseg", sender: nil)
    }
    
    @IBAction func remembermeTriggered(_ sender: AnyObject) {
        selected = !selected
        if selected == true{
            rememberMeButton.setImage(UIImage(named: "lightcheckfilled"), for: .normal)
        }
        else{
            rememberMeButton.setImage(UIImage(named: "lighcheckunfilled"), for: .normal)
        }
    }
    
    func readAuthFile(){
        let filePath = getDocumentsDirectory().appending("/savedData.txt")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            var savedContents = ""
            do {
                savedContents = try NSString(contentsOf: URL(fileURLWithPath: filePath), encoding: String.Encoding.utf8.rawValue) as String
                let contents = savedContents.characters.split(separator: " ").map(String.init)
                username = contents[0]
                pswd = contents[1]
            }
            catch {
                print("Error: "+"\(error)")
            }
        }
    }
    
    func saveAuth(username: String, password: String){
        if remembered == true{
            let filePath = getDocumentsDirectory().appending("/savedData.txt")
            let fileurl = URL(fileURLWithPath: filePath)
            let savedString = username+" "+password
            do{
                try savedString.write(to: fileurl, atomically: false, encoding: String.Encoding.utf8)
            }
            catch{
                print("Error: "+"\(error)")
            }
        }
    }
    
    func getBool(s:String)->Bool{
        switch(s){
            case "True", "true", "yes", "1":
                return true
            case "False", "false", "no", "0":
                return false
            default:
                return false
        }
    }

}
