//
//  Meteorite.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
import RealmSwift

enum APINULL:String, Error {
    case noSize = "-1"
    case noYear = "NoYear"
}

protocol Meteorite {
    var mName: String{ get }
    var mSize: Double{ get }
    var mDate: String{ get }
    var mFall:String{ get }
    var mLocation: Geolocation{ get }
}

struct APIMeteorite:Decodable {
      let name, id, nametype, recclass: String
      let mass: String?
      let fall: String
      let year: String?
      let reclat, reclong: String?
      var geolocation: Geolocation?
    
    init(name:String,
         id:String,
         nametype:String,
         recclass:String,
         mass:String?,
         fall:String,
         year:String?,
         reclat:String?,
         reclong:String?,
         geolocation:Geolocation) {
        self.name = name
        self.id = id
        self.geolocation = geolocation
        self.mass = mass
        self.nametype = nametype
        self.recclass = recclass
        self.reclat = reclat
        self.reclong = reclong
        self.fall = fall
        self.year = year
    }
}

extension APIMeteorite: Meteorite {
    var mName: String { name }
    var mFall:String { fall }
    var mSize: Double {
        if let nMass = Double(mass ?? APINULL.noSize.rawValue) {
            return nMass
        }else {
            return Double(APINULL.noSize.rawValue)!
        }
    }
    var mDate: String { year?.components(separatedBy: "T")[0] ?? APINULL.noYear.rawValue }
    var mLocation: Geolocation { geolocation ?? Geolocation(type: "Point", coordinates: [360,360]) }
}

struct Geolocation: Codable {
    var type: String
    var coordinates: [Double]
    var location: Coordinates{ Coordinates(latitude: coordinates[1],
                                           longitude: coordinates[0])
                              }
    init(type:String,coordinates:[Double]) {
        self.type = type
        self.coordinates = coordinates
    }
}

struct Coordinates {
    var latitude:Double
    var longitude:Double
    var isEmpty:Bool{
        return latitude == 360 && longitude == 360
    }
}
