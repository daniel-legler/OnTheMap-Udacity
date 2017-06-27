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
        
        for student in StoredStudents.shared.students {
            
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin") as? MKPinAnnotationView
        
        guard pin != nil else {
            
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            
            pin!.canShowCallout = true
            
            pin!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return pin
        }
        
        pin!.annotation = annotation
        
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            
            guard let url = view.annotation?.subtitle?! else {
                alert(title: "Error", message: "No link found")
                return
            }
            
            if let url = URL(string: url) {
                
                PM.standard.openURL(url: url)
                
            } else {
                
                alert(title: "Error", message: "No link found")
                
            }
        }
    }
    
    
}
