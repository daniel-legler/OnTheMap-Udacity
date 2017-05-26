//
//  LoginVC.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/12/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit


class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.performSegue(withIdentifier: "Main", sender: nil)
    }
    
    @IBAction func loginButtonPress(_ sender: Any) {
        
//        guard let email = emailField.text, let password = pwField.text, email != "", password != "" else {
//            alert(title: "Error", message: "Enter a valid email/password combination.")
//            return
//        }
        
//        UM.standard.UdacityLogin(email: email, password: password) { (errorResponse) in
        UM.standard.UdacityLogin(email: "daniellegler@gmail.com", password: "dl83193") { (errorResponse) in
            guard errorResponse == nil else {
                self.alert(title: "Error", message: errorResponse!)
                return
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "Main", sender: nil)
            }

        }
    }
}

extension UIViewController {
    
    
    func alert (title: String, message: String, completion: (()->())? = nil){
        DispatchQueue.main.async {            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                completion?()
            }))
            self.present(alert, animated: true, completion: nil)
    
        }
    }
}
