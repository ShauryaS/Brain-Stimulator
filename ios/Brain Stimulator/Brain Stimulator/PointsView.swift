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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        pushPoints()
    }
    
    func addLabels(){
        let label1 = UILabel(frame: CGRect(x:0, y:0, width: width, height: height/2))
        label1.textAlignment = .center
        label1.text = "Points Earned: " + pointsEarned.description
        label1.font = label1.font.withSize(20)
        self.view.addSubview(label1)
        let label2 = UILabel(frame: CGRect(x:0, y:height/2, width: width, height: height/2))
        label2.textAlignment = .center
        points += pointsEarned
        label2.text = "Total Points: " + points.description
        label2.font = label2.font.withSize(30)
        self.view.addSubview(label2)
    }
    
    func pushPoints(){
        firebaseRef.child("users").child(uid).updateChildValues(["points": points])
    }

}
