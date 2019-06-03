//
//  ViewController.swift
//  application_2
//
//  Created by Lizaveta Rudzko on 3/12/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 52.09755 , longitude: 23.68775)
    let regionRadius: CLLocationDistance = 10000
    
    var districts: [String: CLLocationCoordinate2D] = [:]
    
    func centerMapOnLocation(location: CLLocation)
    {
        locationManager.delegate = self
        mapView.delegate = self
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        for district in districts
        {
            print(district)
            mapView.addAnnotation(ArtworkDistrict(title: district.key, coordinate: district.value))
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        readDataFromDB()
        centerMapOnLocation(location: initialLocation)
        print("loaded")
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "newSegue"
        {
            if let vc = segue.destination as? NewViewController
            {
                let artwork = sender as! ArtworkDistrict
                var district = DistrictInfo()
                district.name = artwork.title
                
                district.info = {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    let managedObjectContext = appDelegate.persistentContainer.viewContext
//                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Institution")
                    var info: [String] = []
//                    do{
                        let results = (appDelegate?.getInfo())!
                        for data in results
                        {
                            
                            if (data.value(forKey: "title") as! String) == district.name {
                                info.append(data.value(forKey: "title") as! String)
                            }
                            
                        }
//                    }catch let error as NSError {
//                        print("Data loading error: \(error)")
//                    }
                    
                    return info
                }()
                
                district.latitude = artwork.coordinate.latitude
                district.longitude = artwork.coordinate.longitude
                
                vc.DistrictInfo = district
            }
        }
    }
    
    func readDataFromDB()
    {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
//        let managedObjectContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "District")
        
        //do{
            let results = (appDelegate?.getDistrict())!
            for data in results
            {
                let coordinate = CLLocationCoordinate2D(latitude: data.value(forKey: "latitude") as! CLLocationDegrees , longitude: data.value(forKey: "longitude") as! CLLocationDegrees)
                let title = data.value(forKey: "title") as! String
                districts[title] = coordinate
                
            }
//        }catch let error as NSError {
//            print("Data loading error: \(error)")
//        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.title
        {
            let coordinate = districts[annotationTitle!]
            self.performSegue(withIdentifier: "newSegue", sender: ArtworkDistrict(title: annotationTitle!, coordinate: coordinate!))
        }
    }
    
}

