//
//  ViewController.swift
//  Hodgepods
//
//  Created by Code on 7/29/17.
//  Copyright © 2017 Code. All rights reserved.
//

import UIKit

import MapKit

import Firebase
import FirebaseDatabase
import SCLAlertView

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let initialLocation = CLLocation(latitude: 41.8963,  longitude: -87.6550)
        
        centerMapOnLocation(location: initialLocation)
        
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("pods").observe(DataEventType.value, with: { (snapshot) in
            let pods = snapshot.value as! NSArray
            self.mapView.removeAnnotations(self.mapView.annotations)
            var lowRunningPodNames = [String]()
            for p in pods {
                let podDict = p as! NSDictionary
                let station = Artwork(title: podDict["name"] as! String,
                                      locationName: "Food level: \(podDict["foodCount"]!)" ,
                    discipline: "Subway Station",
                    coordinate: CLLocationCoordinate2D(latitude: podDict["lat"] as! Double,longitude: podDict["long"] as! Double),
                    color: (podDict["foodCount"] as! Int) == 0 ? UIColor.init(red: 1.0, green: 199.0/255.0, blue: 0.0, alpha: 1) : UIColor.init(red: 51.0/255.0, green: 153.0/255.0, blue: 51.0/255.0, alpha: 1))
                (podDict["foodCount"] as! Int) == 0 ? lowRunningPodNames.append(podDict["name"] as! String) : ()
                self.mapView.delegate = self
                self.mapView.addAnnotation(station)
            }
            if (lowRunningPodNames.count > 0 && !SCLAlertView().isBeingPresented) {
                SCLAlertView().showWarning("Just a heads up", subTitle: "Looks like the \(lowRunningPodNames[0]) is running low. Any donations would be greatly appreciated!")
                // TODO: guide me there button, change text of cancel button
            }
        })
            
    }
    
    let regionRadius: CLLocationDistance = 3000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

   

}

