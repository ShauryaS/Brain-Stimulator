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

var bgColor = UIColor.white
var fontColor = UIColor.black
var username = ""
var email = ""
var pswd = ""
var uid = ""
var remembered:Bool!

let firebaseRef = FIRDatabase.database().reference()

func getDocumentsDirectory() -> NSString {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory as NSString
}
