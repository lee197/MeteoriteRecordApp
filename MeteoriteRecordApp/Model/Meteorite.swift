//
//  Meteorite.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

// MARK: - MeteoriteElement
struct Meteorite: Codable {
    let name, id, nametype, recclass: String
    var mass: String?
    let fall: String
    var year:String?
    var date:String{ year?.components(separatedBy: "T")[0] ?? ""}
    let reclat, reclong: String?
    let geolocation: Geolocation?
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let type: String
    let coordinates: [Double]
}

//extension Meteorite: Displayable {
//  var titleLabelText: String {
//    name
//  }
//
//  var sizeLabelText: (label: String, value: String) {
//    if let mass = mass{
//        return ("SIZE", mass)
//    }else{
//        return ("SIZE", "UNKNOW")
//    }
//  }
//
//  var dateLabelText: (label: String, value: String) {
//    ("DATA", year ?? "UNKNOWN")
//  }
//
//  var fallTypeLabelText: (label: String, value: String) {
//    ("FALL TYPE", fall)
//  }
//
//  var latitudeLabelText: (label: String, value: String) {
//    if let geolocation = geolocation{
//       return ("LATITUDE", String(geolocation.coordinates[0]))
//    }else{
//        return ("LATITUDE", "UNKNOW")
//    }
//  }
//
//  var longitutdeLabelText: (label: String, value: String) {
//    if let geolocation = geolocation{
//       return ("LONGITUDE", String(geolocation.coordinates[1]))
//    }else{
//       return ("LONGITUDE", "UNKNOW")
//    }
//  }
//
//  var recTypeLabelText: (label: String, value: String) {
//    ("REC CLASS",recclass)
//  }
//}
