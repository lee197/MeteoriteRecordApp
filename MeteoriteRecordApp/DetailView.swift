//
//  DetailView.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 02/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit
import MapKit

class DetailView: UIView {
    
    var mNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()
    var mSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    var mSizeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "size:"
        label.textColor = .lightGray
        return label
    }()
    var mDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    var mDateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "date:"
        label.textColor = .lightGray
        return label
    }()
    var latitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    var latitudeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "latitude:"
        label.textColor = .lightGray
        return label
    }()
    var longitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    var longitudeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "longitude:"
        label.textColor = .lightGray
        return label
    }()
    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(mapView)
        self.addSubview(mNameLabel)
        self.addSubview(mSizeLabel)
        self.addSubview(mDateLabel)
        self.addSubview(latitudeLabel)
        self.addSubview(longitudeLabel)
        self.addSubview(mapView)
        
        self.addSubview(mSizeTitleLabel)
        self.addSubview(mDateTitleLabel)
        self.addSubview(latitudeTitleLabel)
        self.addSubview(longitudeTitleLabel)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupMapViewConstraints()
        setupSizeLabelConstraints()
        setupDateLabelConstraints()
        setuplatLabelConstraints()
        setupLonLabelConstraints()
        setupNameLabelConstraints()
    }
    
    func setupNameLabelConstraints(){
        NSLayoutConstraint.activate(
            [mNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 110),
             mNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
             mNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 20),
             mNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func setupSizeLabelConstraints(){
        NSLayoutConstraint.activate(
            [mSizeTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
             mSizeTitleLabel.bottomAnchor.constraint(equalTo: mSizeLabel.topAnchor, constant: 0),
             mSizeTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate(
            [mSizeLabel.topAnchor.constraint(equalTo: mNameLabel.bottomAnchor, constant: 60),
             mSizeLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
             mSizeLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 20),
             mSizeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func setupDateLabelConstraints(){
        NSLayoutConstraint.activate(
            [mDateTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
             mDateTitleLabel.bottomAnchor.constraint(equalTo: mDateLabel.topAnchor, constant: 0),
             mDateTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate(
            [mDateLabel.topAnchor.constraint(equalTo: mSizeLabel.bottomAnchor, constant: 60),
             mDateLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
             mDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 20),
             mDateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func setuplatLabelConstraints(){
        NSLayoutConstraint.activate(
            [latitudeTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
             latitudeTitleLabel.bottomAnchor.constraint(equalTo: latitudeLabel.topAnchor, constant: 0),
             latitudeTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate(
            [latitudeLabel.topAnchor.constraint(equalTo: mDateLabel.bottomAnchor, constant: 60),
             latitudeLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
             latitudeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func setupLonLabelConstraints(){
        NSLayoutConstraint.activate(
            [longitudeTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -50),
             longitudeTitleLabel.bottomAnchor.constraint(equalTo: longitudeLabel.topAnchor, constant: 0),
             longitudeTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate(
            [longitudeLabel.topAnchor.constraint(equalTo: mDateLabel.bottomAnchor, constant: 60),
             longitudeLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -50),
             longitudeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupMapViewConstraints(){
        NSLayoutConstraint.activate(
            [mapView.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor,constant: 20),
             mapView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 0),
             mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
             mapView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0),
        ])
        
    }
}
