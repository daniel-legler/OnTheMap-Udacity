//
//  MapVC.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/25/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    var activeUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshStudents()
        
        UM.standard.GetUdacityUser { (user, error) in
            guard error == nil else {
                self.alert(title: "Error", message: error!)
                return
            }
            
            if let user = user {
                self.activeUser = user
            }
            
        }
    }
    
    func refreshStudents() {
        // Loading
        PM.standard.loadRecentStudents { (error) in
            guard error == nil else {
                // Done Loading
                self.alert(title: "Error", message: error!)
                return
            }
            
            // Done Loading
        }
        
        // refreshMap()
        
    }

    
}
