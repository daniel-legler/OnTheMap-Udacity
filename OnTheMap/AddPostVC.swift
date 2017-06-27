//
//  AddPostVC.swift
//  OnTheMap
//
//  Created by Daniel Legler on 6/25/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AddPostVC: UIViewController {

    // Screen 1
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var findOnMapButton: UIButton!
    
    // Screen 2
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mediaTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func findOnTheMap(_ sender: Any) {
        
        Loading.shared.show(view)
        
        guard locationTextField.text != nil, locationTextField.text != "" else {
            Loading.shared.hide()
            alert(title: "Error", message: "Enter a valid location")
            return
        }
        
        CLGeocoder().geocodeAddressString(locationTextField.text!) { (placemarks, error) in
            
            guard error == nil else {
                Loading.shared.hide()
                self.alert(title: "Error", message: "Couldn't find location")
                return
            }
            
            if let placemark = placemarks?.first {
                
                self.showMapAtLocation(placemark.location!.coordinate)
                
            }
            
        }
        
    }
    
    func showMapAtLocation(_ location: CLLocationCoordinate2D) {
        
        titleLabel.isHidden = true
        locationTextField.isHidden = true
        findOnMapButton.isHidden = true
        
        mediaTextField.isHidden = false
        submitButton.isHidden = false
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location , span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        mapView.isHidden = false
        
        Loading.shared.hide()

    }

}
