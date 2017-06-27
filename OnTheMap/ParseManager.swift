//
//  ParseManager.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/25/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit

//enum Response {
//    case data(Data)
//    case error(Error)
//}

typealias PM = ParseManager

class ParseManager: ApiManager {
    
    private override init(){}
    
    static let standard = ParseManager()
    
    private let apiURL = "https://parse.udacity.com/parse/classes/"
    
    func prepareRequestWith(urlParameterString: String) -> NSMutableURLRequest {
        
        let request = NSMutableURLRequest(url: URL(string: apiURL + urlParameterString)!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        return request
        
    }
    
    func loadRecentStudents(_ completion: @escaping (_ error: String?) -> ()) {
        
        let request = prepareRequestWith(urlParameterString: "StudentLocation?limit=100&order=-updatedAt")
        
        ApiRequest(request) { (data, error) in
            guard error == nil else {
                completion(error!)
                print(error!)
                return
            }
            
            guard let data = data as? [String:Any] else { return }
            guard let results = data["results"] as? [[String:Any]] else { return }
            
            StoredStudents.shared.students = []
            for student in results {
                
                if student.count != 10 { continue }
                
                let studentObj = Student(dictionary: student)
                
                if studentObj.fullName.trimmingCharacters(in: CharacterSet.whitespaces) != "" {
                    
                    StoredStudents.shared.students.append(studentObj)
                    
                }
            }
            
            completion(nil)
            
        }
    }
    
    func postStudent(_ student: Student, completion: @escaping (_ error: String?) -> ()) {
        
        let request = prepareRequestWith(urlParameterString: "StudentLocation")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = Method.Post.rawValue.uppercased()
        
        let body = [
            "uniqueKey": student.uniqueKey,
            "firstName": student.firstName,
            "lastName": student.lastName,
            "mapString": student.mapString,
            "mediaURL": student.mediaUrl,
            "latitude": student.latitude,
            "longitude": student.longitude] as [String : Any]
        
        do {
            request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        ApiRequest(request) { (result, error) in
            guard error == nil else {
                completion(error!)
                return
            }
            
            completion(nil)
        }
        
    }
    

    func openURL(url: URL) {
        
        let app = UIApplication.shared
        
        if app.canOpenURL(url) {
            app.open(url, options: [ : ], completionHandler: { (success) in
                
            })
        }
        
    }
}
