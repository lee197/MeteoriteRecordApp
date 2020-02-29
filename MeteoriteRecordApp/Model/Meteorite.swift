//
//  Meteorite.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

enum APINULL: String {
    case noSize = "-1"
    case noYear = "NoYear"
}

protocol Meteorite{
    var mName: String{ get }
    var mSize: String{ get }
    var mDate: String{ get }
    var mLocation: Geolocation{ get }
}
// MARK: - MeteoriteElement
struct APIMeteorite: Codable {
    let name, id, nametype, recclass: String
    let mass: String?
    let fall: String
    let year: String?
    let reclat, reclong: String?
    let geolocation: Geolocation?
}

extension APIMeteorite: Meteorite{
    var mName: String{ name }
    var mSize: String{ mass ?? APINULL.noSize.rawValue }
    var mDate: String{ year?.components(separatedBy: "T")[0] ?? APINULL.noYear.rawValue }
    var mLocation: Geolocation{ geolocation ?? Geolocation(type: "Point", coordinates: []) }
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let type: String
    let coordinates: [Double]
}
