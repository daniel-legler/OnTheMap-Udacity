//
//  ApiManager.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/24/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.


import Foundation
import UIKit

typealias AM = ApiManager

class ApiManager: NSObject {
    
    enum Method: String {
        case Get
        case Post
        case Put
        case Delete
    }
    
    var session: URLSession { return URLSession.shared }

    func ApiRequest(_ request: NSMutableURLRequest, _ completion: @escaping (_ result: Any?, _ error: String?) -> ()) {

        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            guard error == nil else {
                print("Data Task Returned an Error")
                completion(nil, error!.localizedDescription)
                return
            }
            
            guard let status = (response as? HTTPURLResponse)?.statusCode, status != 403 else {
                completion(nil, "Incorrect Username/Password")
                return
            }
            
            guard status >= 200 && status <= 299 else {
                print("Error response status code \(status)")
                completion(nil, "Connection Error")
                return
            }
            
            guard data != nil else {
                print("No Data Returned from API Request")
                completion(nil, "Connection Error")
                return
            }
            
            let newData = self.prepareResponse(data: data!)
            
            do {
                if let json = (try JSONSerialization.jsonObject(with: newData!, options: .allowFragments)) as? [String:Any] {
                    
                    if let errorResponse = json["error"] as? String {
                        completion(nil, errorResponse)
                    } else {
                        completion(json, nil)
                    }
                }
            } catch {
                print("Couldn't make JSON")
                completion(nil, error.localizedDescription)
            }
        }
        task.resume()
    }

    func prepareResponse(data: Data) -> Data? {
        return data
    }
    

 
}
