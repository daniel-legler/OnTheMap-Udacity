//
//  NetworkManager.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/12/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import Foundation

typealias UM = UdacityManager

class UdacityManager: ApiManager {
    
    private override init(){}
    static let standard = UdacityManager()

    
    func ApiRequest(_ request: NSMutableURLRequest, _ completion: @escaping (_ json: [String:Any]?, _ error: String?) -> ()) {
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                completion(nil, error!.localizedDescription)
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            
            do {
                if let json = (try JSONSerialization.jsonObject(with: newData!, options: .allowFragments)) as? [String:Any] {
                    
                    print(json)
                    
                    let errorResponse = json["error"] as? String
                    guard errorResponse == nil else {
                        completion(nil, errorResponse!)
                        return
                    }
                    
                    completion(json, nil)
                    
                }
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
        task.resume()
    }

    func UdacityLogin(email: String, password: String, completion: @escaping (_ error: String?)->()) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        
        ApiRequest(request) { (json, error) in
            guard error == nil else {
                completion(error!)
                return
            }
            
            // Save User ID and Session ID
            
            
            completion(nil)
        }
    }
    
    func UdacityLogout() {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }

        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
        
    }
    
    func GetUdacityUser() {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/users/3903878747")!)

        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
        
    }
}
