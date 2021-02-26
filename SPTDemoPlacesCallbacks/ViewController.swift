//
//  ViewController.swift
//  SPTDemoPlacesCallbacks
//
//  Created by Quentin Beaudouin on 25/02/2021.
//

import UIKit
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var iconStr: String?
    
    init(iconStr: String?, coordinate: CLLocationCoordinate2D ) {
        self.iconStr = iconStr
        self.coordinate = coordinate
        super.init()
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    let placesAnnotations = [PlaceAnnotation(iconStr: "🏠", coordinate: AppDelegate.testHomeCoord),
                             PlaceAnnotation(iconStr: "🏢", coordinate: AppDelegate.testWorkCoord)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        locationManager.requestAlwaysAuthorization()
        mapView.delegate = self
        mapView.addAnnotations(placesAnnotations)
    }
    
    @IBAction func showAnnotationButtonClicked(_ sender: Any) {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.showAnnotations(placesAnnotations, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKind(of: MKUserLocation.self) { return nil }
        
        guard let placeA = annotation as? PlaceAnnotation else { return nil }
        
        let annotationView = MKMarkerAnnotationView(annotation: placeA, reuseIdentifier: "placeAnnot")
        annotationView.clusteringIdentifier = nil
        //annotationView.markerTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        annotationView.glyphText = placeA.iconStr
        
        return annotationView
        
    }
}

