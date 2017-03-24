//
//  ProgressView.swift
//  Brain Stimulator
//
//  Created by Shaurya Srivastava on 11/14/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class ProgressView: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        navigationItem.title = "Progress"
        let alert = UIAlertController(title: "Locked", message: "Feature Coming Soon.", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Okay", style: .default){
            UIAlertAction in
            self.performSegue(withIdentifier: "progtomainseg", sender: nil)
        }

        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
