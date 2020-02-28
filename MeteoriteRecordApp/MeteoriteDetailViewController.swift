//
//  MeteoriteDetailViewController.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 28/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit
import MapKit
class MeteoriteDetailViewController:UIViewController{
    
    @IBOutlet weak var mNameLabel: UILabel!
    @IBOutlet weak var mSizeLabel: UILabel!
    @IBOutlet weak var mDateLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var meteoriteDetailVM: MeteoriteDetailViewModel!
    
    override func viewDidLoad() {
        showOnMap()
        showMeteoriteInfo()
    }
    
    func showMeteoriteInfo(){
        mNameLabel.text = meteoriteDetailVM.getMeteorite().name
        mSizeLabel.text = meteoriteDetailVM.getMeteorite().mass
        mDateLabel.text = meteoriteDetailVM.getMeteorite().date
        latitudeLabel.text = String(meteoriteDetailVM.getMeteorite().geolocation!.coordinates[0])
        longitudeLabel.text = String(meteoriteDetailVM.getMeteorite().geolocation!.coordinates[1])
    }
    
    func showOnMap(){
        let location = CLLocationCoordinate2D(latitude: meteoriteDetailVM.getMeteorite().geolocation!.coordinates[1],
            longitude: meteoriteDetailVM.getMeteorite().geolocation!.coordinates[0])
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
            
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = meteoriteDetailVM.getMeteorite().name
        annotation.subtitle = meteoriteDetailVM.getMeteorite().date
        mapView.addAnnotation(annotation)
    }
    
    
}
