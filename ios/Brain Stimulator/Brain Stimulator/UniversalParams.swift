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

var points = 0
var gamesPlayed = 0
var days = 0

private var correct = 10
private var incorrect = 4

var gameburst = 10
var username = ""
var email = ""
var pswd = ""
var uid = ""
var remembered:Bool!
var game = ""
var gameType = ""
var gameDifficulty = ""
var bgColor = UIColor.white
var fontColor = UIColor.black

let firebaseRef = FIRDatabase.database().reference()

func getDocumentsDirectory() -> NSString {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory as NSString
}
