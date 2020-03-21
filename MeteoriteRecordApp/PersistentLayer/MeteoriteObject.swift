//
//  MeteoriteObject.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 21/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
import RealmSwift

final class MeteoriteObject:Object{
    
    @objc dynamic var name: String = ""
    @objc dynamic var id = 0
    @objc dynamic var nametype = ""
    @objc dynamic var recclass = ""
    @objc dynamic var mass: String? = ""
    @objc dynamic var fall: String = ""
    @objc dynamic var year: String? = ""
    @objc dynamic var reclat: String? = ""
    @objc dynamic var reclong: String? = ""
    @objc dynamic var geolocation: GeolocationObject? = GeolocationObject()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//final class GeolocationObject:Object{
//    @objc dynamic var type = ""
//    @objc dynamic var latitude = 0.0{
//    didSet {
//        compoundKey = compoundKeyValue()
//    }
//    @objc dynamic var longitude = 0.0{
//        didSet {
//            compoundKey = compoundKeyValue()
//        }
//    }
//    @objc dynamic lazy var compoundKey: String = self.compoundKeyValue()
//
//
//    override static func primaryKey() -> String? {
//        return "compoundKey"
//    }
//
//    func compoundKeyValue() -> String {
//        return "\(latitude)\(longitude)"
//    }
//}

public final class GeolocationObject: Object {
    @objc dynamic var type = ""
    @objc dynamic var longitude = 0.0
    @objc dynamic var geoID = 0

    @objc dynamic var latitude = 0.0
    public override static func primaryKey() -> String? {
        return "geoID"
    }

}
