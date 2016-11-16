//
//  Settings.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 11/13/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Settings: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        navigationItem.title = "Settings"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        username = ""
        email = ""
        pswd = ""
        uid = ""
        let filePath = getDocumentsDirectory().appending("/savedData.txt")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            do {
                try fileManager.removeItem(atPath: filePath)
            }
            catch let error as NSError {
                print("Error: "+"\(error)")
            }
        }
        try! FIRAuth.auth()!.signOut()
        self.performSegue(withIdentifier: "backToLogInSegue", sender: sender)
    }

}
