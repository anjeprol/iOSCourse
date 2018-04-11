//
//  ViewController.swift
//  CoreLocationMaps
//
//  Created by Antonio Prado on 4/11/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

enum MapType: Int {
    case Normal = 0
    case Hybrid = 1
    case Satelite = 2
}

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager: CLLocationManager? //Nivel de precisión, tipo de tracking (segundo plano/ sólo cuando este en segundo plano)
    var mapView: MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the location
        loadLocation()
        
        //Setting the map
        loadMap()
        
        //Agregar un pin
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 19.378520, longitude: -99.1784021)
        pointAnnotation.title = "AMK technologies"
        pointAnnotation.subtitle = "Chilaquiles free"
        mapView?.addAnnotation(pointAnnotation)
        
      /*  let region = MKCoordinateRegionMakeWithDistance(pointAnnotation.coordinate, 500, 500)
        
       Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
            self.mapView?.setRegion(region, animated: true)
        }) */
        
        let toolBar = UIToolbar(frame: CGRect(x:0, y:mapView!.frame.maxY, width: view.frame.width, height: 50))
        let normalB = UIBarButtonItem(title: "Normal", style: .plain, target: self, action: #selector(mapTypePressed(sender:)))
        let fixSpace1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let hybridB = UIBarButtonItem(title: "Hybrid", style: .plain, target: self, action: #selector(mapTypePressed(sender:)))
        let fixSpace2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let sateliteB = UIBarButtonItem(title: "Satelite", style: .plain, target: self, action:  #selector(mapTypePressed(sender:)))
        
        normalB.tag = MapType.Normal.hashValue
        hybridB.tag = MapType.Hybrid.hashValue
        sateliteB.tag = MapType.Satelite.hashValue
        
        toolBar.items = [normalB, fixSpace1, hybridB, fixSpace2, sateliteB]
        view.addSubview(toolBar)
        
        //Serializando JSON
        // Bundle te ayuda a cceder a elementos que fueron compilados junto al IPA
        let path = Bundle.main.path(forResource: "DF", ofType: "json")
        let url = URL(fileURLWithPath: path ?? "")
        
        do {
            let data = try Data(contentsOf: url)
            
            // Intentamos interpretar el object del JSON a 1 objeto de Swift
            if let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                
                let coordinatesArray = result["coord_area"] as? [NSDictionary]
                
                var coords = [CLLocationCoordinate2D]()
                for coordinate in coordinatesArray ?? [NSDictionary]() {
                    
                    let latitudeStr = coordinate["lon"] as? String
                    let longitudeStr = coordinate["lat"] as? String
                    
                    let coordinateObj = CLLocationCoordinate2D(latitude: Double(latitudeStr!)!, longitude: Double(longitudeStr!)!)
                    coords.append(coordinateObj)
                    
                    //Adding to map
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinateObj
                    mapView?.addAnnotation(annotation)
                }
            }
            
        } catch let error {
            print("El error fue: \(error.localizedDescription)")
        }
    }

    @objc func mapTypePressed(sender: UIBarButtonItem){
        
        switch sender.tag {
        case MapType.Normal.hashValue:
            mapView?.mapType = .standard
        case MapType.Hybrid.hashValue:
            mapView?.mapType = .hybridFlyover
        case MapType.Satelite.hashValue:
            mapView?.mapType = .satelliteFlyover
        default: break
        }

    }
    
    func loadMap(){
        mapView = MKMapView(frame: CGRect(x:0, y:0, width: view.frame.width, height: view.frame.height-50))
        mapView?.showsTraffic = true
        mapView?.showsScale = true
        mapView?.showsCompass = true
        mapView?.showsUserLocation = true
        view.addSubview(mapView!)
    }

    func loadLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        //locationManager?.requestAlwaysAuthorization() monitorea el dispositivo aunque este en background
    }
    
    //MARL: CoreLocation Delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            print("ya acepto!")
        case .denied:
            print("Denegó")
        case .notDetermined:
            print("No de define el usuario")
        case .restricted:
            print("Restringido")
            locationManager?.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.first
        //Current location
        print("Latitude: \(currentLocation!.coordinate.latitude), Longitude: \(currentLocation!.coordinate.longitude)")
        
        let region = MKCoordinateRegionMakeWithDistance(currentLocation!.coordinate, 500, 500)
        mapView?.region = region
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

