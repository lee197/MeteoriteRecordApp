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
    var date:String{year?.components(separatedBy: "T")[0] ?? ""}
    let reclat, reclong: String?
    let geolocation: Geolocation?
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let type: String
    let coordinates: [Double]
}
