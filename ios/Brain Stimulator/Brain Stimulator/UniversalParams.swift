//
//  UniversalParams.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 10/23/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var bgColor = UIColor.black
var fontColor = UIColor.white
var username = ""
var email = ""
var pswd = ""
var remembered:Bool!

let firebaseRef = FIRDatabase.database().reference()

var CURRENT_USER: FIRDatabaseReference
{
    let userID = UserDefaults.standard.value(forKey: "uid") as! String
    let currentUser = firebaseRef.child("users").child(userID)
    return currentUser
}
