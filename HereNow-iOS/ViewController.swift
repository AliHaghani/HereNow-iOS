//
//  ViewController.swift
//  HereNow-iOS
//
//  Created by Ali Haghani on 2016-01-24.
//  Copyright © 2016 Ali Haghani. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var searchText: UISearchBar!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    @IBAction func textFieldReturn(sender: AnyObject) {
        sender.resignFirstResponder()
        mapView.removeAnnotations(mapView.annotations)
        self.performSearch()
    }
    
    func performSearch() {
        
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler({(response: MKLocalSearchResponse?, error: NSError?) in
            
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    
                    var annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        searchText.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }


}

