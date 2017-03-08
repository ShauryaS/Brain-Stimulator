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

var correct:[Int] = [4, 8, 12]
var incorrect:[Int] = [2, 4, 6]

var gameburst = 0
var username = ""
var email = ""
var pswd = ""
var uid = ""
var remembered:Bool!
var game = ""
var gameType = ""
var gameDifficulty = ""
var bgColor = UIColor.init(displayP3Red: 20.0/255.0, green: 26.0/255.0, blue: 36.0/255.0, alpha: 1.0)
var fontColor = UIColor.white
var tintColor = UIColor.red
var isTherapist = false
var darkMode = false

let firebaseRef = FIRDatabase.database().reference()

func getDocumentsDirectory() -> NSString {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory as NSString
}

func getColor(color:String) -> UIColor{
    switch(color){
    case "Red":
        return UIColor.red
    case "Dark Red":
        return UIColor.init(displayP3Red: 163.0/255.0, green: 25.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    case "Orange":
        return UIColor.orange
    case "Yellow":
        return UIColor.yellow
    case "Gold":
        return UIColor.init(displayP3Red: 255.0/255.0, green: 215.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    case "Green":
        return UIColor.green
    case "Dark Green":
        return UIColor.init(displayP3Red: 25.0/255.0, green: 93.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    case "Blue":
        return UIColor.blue
    case "Purple":
        return UIColor.purple
    case "Brown":
        return UIColor.brown
    case "Gray":
        return UIColor.gray
    case "Indigo":
        return UIColor.init(displayP3Red: 75.0/255.0, green: 0.0/255.0, blue: 130.0/255.0, alpha: 1.0)
    case "Violet":
        return UIColor.init(displayP3Red: 238.0/255.0, green: 130.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    case "Black":
        return UIColor.black
    case "Cyan":
        return UIColor.cyan
    case "Royal Blue":
        return UIColor.init(displayP3Red: 65.0/255.0, green: 105.0/255.0, blue: 225.0/255.0, alpha: 1.0)
    case "Magenta":
        return UIColor.magenta
    case "Peach":
        return UIColor.init(displayP3Red: 255.0/255.0, green: 218.0/255.0, blue: 185.0/255.0, alpha: 1.0)
    case "Tan":
        return UIColor.init(displayP3Red: 210.0/255.0, green: 180.0/255.0, blue: 140.0/255.0, alpha: 1.0)
    case "Turquoise":
        return UIColor.init(displayP3Red: 64.0/255.0, green: 224.0/255.0, blue: 208.0/255.0, alpha: 1.0)
    default:
        return UIColor.white
    }
}
