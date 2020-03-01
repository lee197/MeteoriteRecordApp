//
//  MeteoriteDetailViewController.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 28/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit
import MapKit
class MeteoriteDetailViewController:UIViewController {
    
    @IBOutlet weak var mNameLabel: UILabel!
    @IBOutlet weak var mSizeLabel: UILabel!
    @IBOutlet weak var mDateLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var meteoriteDetailVM: MeteoriteDetailViewModel
    
    init?(coder: NSCoder, meteoriteDetailVM: MeteoriteDetailViewModel) {
          self.meteoriteDetailVM = meteoriteDetailVM
          super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
          fatalError("You must create this view controller with a meteoriteDetailVM.")
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        showOnMap()
        showMeteoriteInfo()
    }
    
    func showMeteoriteInfo() {
        mNameLabel.text = meteoriteDetailVM.getMeteorite().mName
        mSizeLabel.text = String(meteoriteDetailVM.getMeteorite().mSize)
        mDateLabel.text = meteoriteDetailVM.getMeteorite().mDate
        latitudeLabel.text = String(meteoriteDetailVM.getMeteorite().mLocation.coordinates[0])
        longitudeLabel.text = String(meteoriteDetailVM.getMeteorite().mLocation.coordinates[1])
    }
    
    func showOnMap() {
        let location = CLLocationCoordinate2D(latitude: meteoriteDetailVM.getMeteorite().mLocation.coordinates[1],
            longitude: meteoriteDetailVM.getMeteorite().mLocation.coordinates[0])
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
            
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = meteoriteDetailVM.getMeteorite().mName
        annotation.subtitle = meteoriteDetailVM.getMeteorite().mDate
        mapView.addAnnotation(annotation)
    }
    
    
}
