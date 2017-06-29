//
//  PointsView.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 2/15/17.
//  Copyright © 2017 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class PointsView: UIViewController{
    
    var width = 0
    var height = 0
    var pointsEarned = 0
    
    var corrAns = 0
    var incorrAns = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        width = Int(UIScreen.main.bounds.width)
        height = Int(UIScreen.main.bounds.height)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PointsView.doneViewingPoints))
        view.addGestureRecognizer(tap)
    }
    
    func doneViewingPoints(){
        self.performSegue(withIdentifier: "pvtomainsegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addLabels()
        if(loggedIn)==true{
            pushPoints()
        }
    }
    
    func addLabels(){
        let label1 = UILabel(frame: CGRect(x:0, y:0, width: width, height: height/4))
        label1.textAlignment = .center
        label1.text = "Correct Answers: " + corrAns.description
        label1.font = label1.font.withSize(20)
        label1.textColor = getColor(color: "Dark Green")
        self.view.addSubview(label1)
        let label2 = UILabel(frame: CGRect(x:0, y:height/4, width: width, height: height/4))
        label2.textAlignment = .center
        label2.text = "Incorrect Answers: " + incorrAns.description
        label2.font = label2.font.withSize(20)
        label2.textColor = getColor(color: "Dark Red")
        self.view.addSubview(label2)
        let label3 = UILabel(frame: CGRect(x:0, y:2*height/4, width: width, height: height/4))
        label3.textAlignment = .center
        label3.text = "Points Earned: " + pointsEarned.description
        label3.font = label3.font.withSize(20)
        label3.textColor = getColor(color: "Orange")
        self.view.addSubview(label3)
        let label4 = UILabel(frame: CGRect(x:0, y:3*height/4, width: width, height: height/4))
        label4.textAlignment = .center
        points += pointsEarned
        label4.text = "Total Points: " + points.description
        label4.font = label4.font.withSize(20)
        label4.textColor = getColor(color: "Gold")
        self.view.addSubview(label4)
    }
    
    func pushPoints(){
        firebaseRef.child("users").child(uid).updateChildValues(["points": points])
    }

}
