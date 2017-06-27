//
//  UIViewControllerExtensions.swift
//  OnTheMap
//
//  Created by Daniel Legler on 6/26/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    

    
}
