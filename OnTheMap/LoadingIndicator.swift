//
//  LoadingIndicator.swift
//  OnTheMap
//
//  Created by Daniel Legler on 6/26/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit

class Loading {
    
    static let shared = Loading()
    
    private let activity = UIActivityIndicatorView(frame: UIScreen.main.bounds)
    private let background = UIView(frame: UIScreen.main.bounds)
    
    func show(_ view: UIView) {
        
        background.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        activity.activityIndicatorViewStyle = .whiteLarge
        activity.startAnimating()
        
        background.addSubview(activity)
        view.addSubview(background)
        
    }
    
    func hide() {
        Loading.shared.background.removeFromSuperview()
    }
    
    
}
