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
    associatedtype Query: QueryType

    init(managedObject: ManagedObject)

    func managedObject() -> ManagedObject
}

public protocol QueryType {
    var predicate: NSPredicate? { get }
    var sortDescriptors: [SortDescriptor] { get }
}

public enum DefaultQuery: QueryType {

    public var predicate: NSPredicate? {
        return nil
    }

    public var sortDescriptors: [SortDescriptor] {
        return []
    }
}
