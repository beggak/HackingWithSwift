//
//  ViewController.swift
//  Project16
//
//  Created by begaiym akunova on 15/6/22.
//

import UIKit
import MapKit
import Contacts

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeMapType))
        
        let coords = CLLocationCoordinate2DMake(51.5083, -0.1384)
        let address = [CNPostalAddressStreetKey: "181 Piccadilly, St. James's", CNPostalAddressCityKey: "London", CNPostalAddressPostalCodeKey: "W1A 1ER", CNPostalAddressISOCountryCodeKey: "GB"]
        let place = MKPlacemark(coordinate: coords, addressDictionary: address)

        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotation(place)
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Choose how you want to view the map", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = MKMapType.satellite
        }))
        ac.addAction(UIAlertAction(title: "Standart", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = MKMapType.standard
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = MKMapType.hybrid
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView  = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        //return annotationView
        if let annotationView = annotationView as? MKPinAnnotationView {
            annotationView.pinTintColor = UIColor.green
            return annotationView
        } else {
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Learn more..", style: .default, handler: { [weak self] _ in
            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Wikipedia") as? WikipediaController {
                vc.urlString = placeName
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }))
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    



}

