//
//  ArtworkDistrict.swift
//  
//
//  Created by Lizaveta Rudzko on 3/12/1398 AP.
//

import Foundation
import MapKit

class ArtworkDistrict: NSObject, MKAnnotation
{
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return title
    }
}
