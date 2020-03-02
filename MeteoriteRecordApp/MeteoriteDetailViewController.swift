//
//  MeteoriteDetailViewController.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 28/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit
import MapKit
class MeteoriteDetailViewController: UIViewController {
    
    var meteoriteDetailVM: MeteoriteDetailViewModel
    var detailView: DetailView!
    
    init(meteoriteDetailVM: MeteoriteDetailViewModel) {
        self.meteoriteDetailVM = meteoriteDetailVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let detailView = DetailView(frame: UIScreen.main.bounds)
        self.view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            detailView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            detailView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            detailView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
        ])
        self.detailView = detailView
        self.detailView.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showOnMap()
        showMeteoriteInfo()
    }
    
    func showMeteoriteInfo() {
        detailView.mNameLabel.text = meteoriteDetailVM.getMeteorite().mName
        detailView.mSizeLabel.text = String(meteoriteDetailVM.getMeteorite().mSize)
        detailView.mDateLabel.text = meteoriteDetailVM.getMeteorite().mDate
        detailView.latitudeLabel.text = String(meteoriteDetailVM.getMeteorite().mLocation.coordinates[0])
        detailView.longitudeLabel.text = String(meteoriteDetailVM.getMeteorite().mLocation.coordinates[1])
    }
    
    func showOnMap() {
        let location = CLLocationCoordinate2D(latitude: meteoriteDetailVM.getMeteorite().mLocation.coordinates[1],
                                              longitude: meteoriteDetailVM.getMeteorite().mLocation.coordinates[0])
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        detailView.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = meteoriteDetailVM.getMeteorite().mName
        annotation.subtitle = meteoriteDetailVM.getMeteorite().mDate
        detailView.mapView.addAnnotation(annotation)
    }
    
}
