//
//  Container.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 21/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
import RealmSwift

public final class Container {
  private let realm: Realm

  public convenience init() throws {
    try self.init(realm: Realm())
  }

  internal init(realm: Realm) {
    self.realm = realm
    print(Realm.Configuration.defaultConfiguration.fileURL!)
  }

  public func write(_ block: (WriteTransaction) throws -> Void) throws {
    let transaction = WriteTransaction(realm: realm)
    try realm.write {
      try block(transaction)
    }
  }
}
