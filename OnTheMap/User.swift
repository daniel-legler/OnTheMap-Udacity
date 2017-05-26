//
//  User.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/23/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import Foundation

class User {
    
    var id: String = ""
    var firstName: String = ""
    var lastName: String = ""
    
    var fullName: String {
        return firstName + " " + lastName
    }
    
    init(id: String, first: String, last: String) {
        self.id = id
        self.firstName = first
        self.lastName = last
    }
    
    
}
