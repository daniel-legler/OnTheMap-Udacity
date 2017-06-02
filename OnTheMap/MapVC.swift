//
//  MapVC.swift
//  OnTheMap
//
//  Created by Daniel Legler on 5/25/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {

    var activeUser: User!
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
                
        UM.standard.GetUdacityUser { (user, error) in
            guard error == nil else {
                self.alert(title: "Error", message: error!)
                return
            }
            
            if let user = user {
                self.activeUser = user
            }
            
        }
    }
    
    func refreshMap() {
        
        mapView.removeAnnotations(mapView.annotations)
        
        var annotations = [MKPointAnnotation]()
        
        for student in PM.standard.students {
            
            let lat = CLLocationDegrees(student.latitude)
            let long = CLLocationDegrees(student.longitude)

            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            annotation.title = student.fullName
            annotation.subtitle = student.mediaUrl
            
            annotations.append(annotation)
        }
        
        self.mapView.addAnnotations(annotations)
    }
    
    
    
}
