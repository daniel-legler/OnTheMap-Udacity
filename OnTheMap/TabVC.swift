//
//  TabVC.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/26/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit

class TabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshStudents()
        
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        Loading.shared.show(view)
        self.refreshStudents()
    }

    func refreshStudents() {
        // Loading
        PM.standard.loadRecentStudents { (error) in
            guard error == nil else {
                // Done Loading
                self.alert(title: "Error", message: error!)
                return
            }
            
//          PM.standard.students is now updated
            DispatchQueue.main.async {
                
                (self.viewControllers![0] as! MapVC).refreshMap()
                (self.viewControllers![1] as! ListVC).refreshList()
                
                Loading.shared.hide()
                
            }


        }
        
    }


}
