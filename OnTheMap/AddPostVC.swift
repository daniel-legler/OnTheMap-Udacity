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

    var selectedCoordinate: CLLocationCoordinate2D!
    
    
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
        
        // Check that the location text field is not blank
        guard locationTextField.text != nil, locationTextField.text != "" else {
            Loading.shared.hide()
            alert(title: "Error", message: "Enter a valid location")
            return
        }
        
        // Attempt to geocode the provided location string
        CLGeocoder().geocodeAddressString(locationTextField.text!) { (placemarks, error) in
            
            guard error == nil else {
                Loading.shared.hide()
                self.alert(title: "Error", message: "Couldn't find that location")
                return
            }
            
            if let placemark = placemarks?.first {
                
                // If  at least one placemark is found, show it on the map
                self.selectedCoordinate = placemark.location!.coordinate
                self.showMapAtLocation(self.selectedCoordinate)
                
            }
        }
    }
    
    func showMapAtLocation(_ location: CLLocationCoordinate2D) {
        
        // Hide screen 1 elements
        titleLabel.isHidden = true
        locationTextField.isHidden = true
        findOnMapButton.isHidden = true
        
        // Show screen 2 elements
        mediaTextField.isHidden = false
        submitButton.isHidden = false
        
        // Set up the mapview
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location , span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        mapView.isHidden = false
        
        // Hide the loading animation
        Loading.shared.hide()

    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        guard mediaTextField.text != nil, mediaTextField.text != "" else {
            self.alert(title: "Error", message: "Please enter a link to share your study spot")
            return
        }
        
        Loading.shared.show(view)
        
        UM.standard.GetUdacityUser { (user, error) in
            
            guard error == nil else {
                Loading.shared.hide()
                self.alert(title: "Error", message: error!)
                return
            }
            
            let student = Student(dictionary: ["firstName": user!.firstName,
                                   "lastName": user!.lastName,
                                   "longitude": Double(self.selectedCoordinate.longitude),
                                   "latitude": Double(self.selectedCoordinate.latitude),
                                   "mediaURL": self.mediaTextField.text!,
                                   "mapString": self.locationTextField.text!,
                                   "objectId": "",
                                   "uniqueKey": user!.id])
                
            PM.standard.postStudent(student) { (result) in
//            print(result)
            }

        }
        
        
    }

}
