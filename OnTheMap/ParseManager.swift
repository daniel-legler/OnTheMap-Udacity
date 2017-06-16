//
//  ParseManager.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/25/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import Foundation


typealias PM = ParseManager

class ParseManager: ApiManager {
    
    var students = [Student]()
 
    private override init(){}
    static let standard = ParseManager()
    
    func loadRecentStudents(_ completion: @escaping (_ error: String?) -> ()) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")

        
        ApiRequest(request) { (data, error) in
            guard error == nil else {
                completion(error!)
                print(error!)
                return
            }
            
            guard let data = data as? [String:Any] else { return }
            guard let results = data["results"] as? [[String:Any]] else { return }
            
            PM.standard.students = []
            for student in results {
                
                if student.count != 10 { continue }
                
                let studentObj = Student(dictionary: student)
                
                if studentObj.fullName.trimmingCharacters(in: CharacterSet.whitespaces) != "" {
                    
                    PM.standard.students.append(studentObj)
                    
                }
            }
            
            completion(nil)
            
        }
    }
}
