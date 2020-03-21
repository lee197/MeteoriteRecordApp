//
//  Character+Persistable.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 21/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
import RealmSwift

extension APIMeteorite: Persistable {
    
    public init(managedObject: MeteoriteObject) {
        name = managedObject.name
        id = String(managedObject.id)
        recclass = managedObject.recclass
        nametype = managedObject.nametype
        mass = managedObject.mass
        fall = managedObject.fall
        year = managedObject.year
        reclat = managedObject.reclat
        reclong = managedObject.reclong
        geolocation = Geolocation.init(type: "", coordinates: [])
        geolocation?.coordinates = [managedObject.geolocation?.latitude ?? 0.0,managedObject.geolocation?.longitude ?? 0.0]
        geolocation?.type = managedObject.geolocation?.type ?? ""
    }
    
    public func managedObject() -> MeteoriteObject {
        let meteorite = MeteoriteObject()
        meteorite.name = name
        meteorite.id = Int(id) ?? 0
        meteorite.recclass = recclass
        meteorite.nametype = nametype
        meteorite.mass = mass
        meteorite.fall = fall
        meteorite.year = year
        meteorite.reclat = reclat
        meteorite.reclong = reclong
        meteorite.geolocation?.latitude = geolocation?.coordinates[0] ?? 0
        meteorite.geolocation?.longitude = geolocation?.coordinates[1] ?? 0
        meteorite.geolocation?.type = geolocation?.type ?? ""
        meteorite.geolocation?.geoID = Int((geolocation?.coordinates[0] ?? 0)*100000)
        
        return meteorite
    }
    
}

extension APIMeteorite {
  public enum Query: QueryType {
    case publisherName(String)

    public var predicate: NSPredicate? {
      switch self {
      case .publisherName(let value):
        return NSPredicate(format: "publisher.name == %@", value)
      }
    }

    public var sortDescriptors: [SortDescriptor] {
      return [SortDescriptor(keyPath:"name")]
    }
  }
}
