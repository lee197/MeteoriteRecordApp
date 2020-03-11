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
        label.font = UIFont.boldSystemFont(ofSize: Layout.LabelFontSize.title)
        return label
    }()
    var mSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: Layout.LabelFontSize.smallTitle)
        return label
    }()
   private var mSizeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: Layout.LabelFontSize.content)
        label.text = "size:"
        label.textColor = .lightGray
        return label
    }()
    var mDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: Layout.LabelFontSize.smallTitle)
        return label
    }()
   private var mDateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: Layout.LabelFontSize.content)
        label.text = "date:"
        label.textColor = .lightGray
        return label
    }()
    var latitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: Layout.LabelFontSize.smallTitle)
        return label
    }()
   private var latitudeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: Layout.LabelFontSize.content)
        label.text = "latitude:"
        label.textColor = .lightGray
        return label
    }()
    var longitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: Layout.LabelFontSize.smallTitle)
        return label
    }()
   private var longitudeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: Layout.LabelFontSize.content)
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
    
   private func setupViews() {
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
    
   private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupMapViewConstraints()
        setupSizeLabelConstraints()
        setupDateLabelConstraints()
        setuplatLabelConstraints()
        setupLonLabelConstraints()
        setupNameLabelConstraints()
    }
    
   private func setupNameLabelConstraints(){
        NSLayoutConstraint.activate(
            [mNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 110),
             mNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: Layout.LabelConstraint.leading),
             mNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: Layout.LabelConstraint.trailing),
             mNameLabel.heightAnchor.constraint(equalToConstant: Layout.LabelSize.height)
        ])
    }
   private func setupSizeLabelConstraints(){
        NSLayoutConstraint.activate(
            [mSizeTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: Layout.LabelConstraint.leading),
             mSizeTitleLabel.bottomAnchor.constraint(equalTo: mSizeLabel.topAnchor, constant: Layout.LabelConstraint.bottom),
             mSizeTitleLabel.heightAnchor.constraint(equalToConstant: Layout.LabelSize.height)
        ])
        NSLayoutConstraint.activate(
            [mSizeLabel.topAnchor.constraint(equalTo: mNameLabel.bottomAnchor, constant: Layout.LabelConstraint.top),
             mSizeLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: Layout.LabelConstraint.leading),
             mSizeLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: Layout.LabelConstraint.trailing),
             mSizeLabel.heightAnchor.constraint(equalToConstant: Layout.LabelSize.height)
        ])
    }
  private func setupDateLabelConstraints(){
        NSLayoutConstraint.activate(
            [mDateTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: Layout.LabelConstraint.leading),
             mDateTitleLabel.bottomAnchor.constraint(equalTo: mDateLabel.topAnchor, constant: Layout.LabelConstraint.bottom),
             mDateTitleLabel.heightAnchor.constraint(equalToConstant: Layout.LabelSize.height)
        ])
        NSLayoutConstraint.activate(
            [mDateLabel.topAnchor.constraint(equalTo: mSizeLabel.bottomAnchor, constant: Layout.LabelConstraint.top),
             mDateLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: Layout.LabelConstraint.leading),
             mDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: Layout.LabelConstraint.trailing),
             mDateLabel.heightAnchor.constraint(equalToConstant: Layout.LabelSize.height)
        ])
    }
   private func setuplatLabelConstraints(){
        NSLayoutConstraint.activate(
            [latitudeTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: Layout.LabelConstraint.leading),
             latitudeTitleLabel.bottomAnchor.constraint(equalTo: latitudeLabel.topAnchor, constant: Layout.LabelConstraint.bottom),
             latitudeTitleLabel.heightAnchor.constraint(equalToConstant: Layout.LabelSize.height)
        ])
        NSLayoutConstraint.activate(
            [latitudeLabel.topAnchor.constraint(equalTo: mDateLabel.bottomAnchor, constant: Layout.LabelConstraint.top),
             latitudeLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: Layout.LabelConstraint.leading),
             latitudeLabel.heightAnchor.constraint(equalToConstant: Layout.LabelSize.height)
        ])
    }
   private func setupLonLabelConstraints(){
        NSLayoutConstraint.activate(
            [longitudeTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -50),
             longitudeTitleLabel.bottomAnchor.constraint(equalTo: longitudeLabel.topAnchor, constant: Layout.LabelConstraint.bottom),
             longitudeTitleLabel.heightAnchor.constraint(equalToConstant: Layout.LabelSize.height)
        ])
        NSLayoutConstraint.activate(
            [longitudeLabel.topAnchor.constraint(equalTo: mDateLabel.bottomAnchor, constant: Layout.LabelConstraint.top),
             longitudeLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -50),
             longitudeLabel.heightAnchor.constraint(equalToConstant: Layout.LabelSize.height)
        ])
    }
    
   private func setupMapViewConstraints(){
        NSLayoutConstraint.activate(
            [mapView.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor,constant: 20),
             mapView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 0),
             mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
             mapView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0),
        ])
        
    }
}

private extension DetailView{
    
    enum Layout{
        
        enum LabelFontSize{
            
            static let title:CGFloat = 36
            static let content:CGFloat = 16
            static let smallTitle:CGFloat = 14
        }
        
        enum LabelSize{
            static let height:CGFloat = 30
        }
        
        enum LabelConstraint{
              static let leading:CGFloat = 20
              static let trailing:CGFloat = 20
              static let top:CGFloat = 60
              static let bottom:CGFloat = 0
          }
    }
}
