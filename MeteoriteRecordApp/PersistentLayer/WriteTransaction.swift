//
//  WriteTransaction.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 21/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
import RealmSwift

public final class WriteTransaction {
  private let realm: Realm

  internal init(realm: Realm) {
    self.realm = realm
  }

  public func add<T: Persistable>(_ value: T, update: Realm.UpdatePolicy) {
    realm.add(value.managedObject(), update: update)
  }
}
