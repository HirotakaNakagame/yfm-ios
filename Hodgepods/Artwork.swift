//
//  Artwork.swift
//  Hodgepods
//
//  Created by Code on 7/29/17.
//  Copyright © 2017 Code. All rights reserved.
//

import Foundation


import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let color: UIColor
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, color: UIColor) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.color = color
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
