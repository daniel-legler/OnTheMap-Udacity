//
//  AddPostVC.swift
//  OnTheMap
//
//  Created by Daniel Legler on 6/25/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit
import CoreLocation

class AddPostVC: UIViewController {

    @IBOutlet weak var LocationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func findOnTheMap(_ sender: Any) {
        guard LocationTextField.text != nil, LocationTextField.text != "" else {
            alert(title: "Error", message: "Enter a valid location")
            return
        }
        
        
    }
    

}
