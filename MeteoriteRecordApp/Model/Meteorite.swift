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
    var mSize: Double{ get }
    var mDate: String{ get }
    var mLocation: Geolocation{ get }
}

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
    var mSize: Double{
        if let nMass = Double(mass ?? APINULL.noSize.rawValue){
            return nMass
        }else{
            return Double(APINULL.noSize.rawValue)!
        }
    }
    var mDate: String{ year?.components(separatedBy: "T")[0] ?? APINULL.noYear.rawValue }
    var mLocation: Geolocation{ geolocation ?? Geolocation(type: "Point", coordinates: []) }
}

struct Geolocation: Codable {
    let type: String
    let coordinates: [Double]
}
