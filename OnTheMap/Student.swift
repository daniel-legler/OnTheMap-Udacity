//
//  Student.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/25/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import Foundation

struct Student {
    
    var firstName: String
    var lastName: String
    var longitude: Double
    var latitude: Double
    var mediaUrl: String
    var mapString: String
    var objectId: String
    var uniqueKey: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }

    
    init(dictionary: [String : Any]) {
        firstName = (dictionary["firstName"] ?? "") as! String
        lastName = (dictionary["lastName"] ?? "") as! String
        longitude = (dictionary["longitude"] ?? 0) as! Double
        latitude = (dictionary["latitude"] ?? 0) as! Double
        mediaUrl = (dictionary["mediaURL"] ?? "") as! String
        mapString = (dictionary["mapString"] ?? "") as! String
        objectId = (dictionary["objectId"] ?? "") as! String
        uniqueKey = (dictionary["uniqueKey"] ?? "") as! String
    }
    
    
}

class StoredStudents {
    
    var students = [Student]()

    static let shared = StoredStudents()
    
}
