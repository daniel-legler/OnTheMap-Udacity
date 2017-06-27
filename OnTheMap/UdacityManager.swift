//
//  UdacityManager.swift
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

    var sessionId: String? = nil
    var userId: String? = nil

    func UdacityLogin(email: String, password: String, completion: @escaping (_ error: String?)->()) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = Method.Post.rawValue.uppercased()
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        
        ApiRequest(request) { (json, error) in
            guard error == nil else {
                completion(error!)
                return
            }
            
            guard let json = json as? [String:Any] else { return }
            
            guard let account = json["account"] as? [String:Any] else { return }
            guard let userId = account["key"] as? String else { return }

            guard let sessionJson = json["session"] as? [String:Any] else { return }
            guard let sessionId = sessionJson["id"] as? String else { return }
            
            self.userId = userId
            self.sessionId = sessionId
            
            completion(nil)
        }
    }
    
    func UdacityLogout() {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = Method.Delete.rawValue.uppercased()
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
            let newData = data?.subdata(in: range)
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
        
    }
    
    func GetUdacityUser(completion: @escaping (_ user: User?, _ error: String?)->()) {
        
        guard let id = self.userId else {
            completion(nil, "Error: User not yet loaded")
            return
        }
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/users/\(id)")!)
        
        
        ApiRequest(request) { (data, error) in
            guard error == nil else {
                completion(nil, error!)
                return
            }
            
            guard let data = data as? [String:Any] else { return }
            
            guard let userData = data["user"] as? [String:Any] else {
                print("Couldn't get User Data")
                completion(nil, "User data")
                return
            }
            guard let firstName = userData["first_name"] as? String else { return }
            guard let lastName = userData["last_name"] as? String else { return }
            
            completion(User(id: id, first: firstName, last: lastName), nil)
            
        }
        
    }
    
    override func prepareResponse(data: Data?) -> Data? {
        let range = Range(5..<data!.count)
        return data?.subdata(in: range)
    }
}
