//
//  Persistable.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 21/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
import RealmSwift

public protocol Persistable {

    associatedtype ManagedObject: Object

    init(managedObject: ManagedObject)

    func managedObject() -> ManagedObject
}
