//
//  ViewController.swift
//  mapKit
//
//  Created by SHUN on 2016/7/4.
//  Copyright © 2016年 NKG. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var manager:CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
   
        manager = CLLocationManager()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        //manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString("台灣新北市土城區立德路", completionHandler:  {
            placemark ,error in
            
            print(error)
            
            let annotation = MKPointAnnotation()
            annotation.title = "test place"
            annotation.coordinate = (placemark?.first?.location?.coordinate)!
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
            
        })
        
        

    }

}

