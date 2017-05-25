//
//  ApiManager.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/24/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import Foundation


//
//  NetworkManager.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/12/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import Foundation

typealias AM = ApiManager

class ApiManager: NSObject {
    
    enum Method: String {
        case Get
        case Post
        case Put
        case Delete
    }
    
    var session: URLSession { return URLSession.shared }

    
    
 
}
