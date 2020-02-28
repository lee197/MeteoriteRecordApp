//
//  Displayable.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

protocol Displayable {
  var titleLabelText: String { get }
  var sizeLabelText: (label: String, value: String) { get }
  var dateLabelText: (label: String, value: String) { get }
  var fallTypeLabelText: (label: String, value: String) { get }
  var latitudeLabelText: (label: String, value: String) { get }
  var longitutdeLabelText: (label: String, value: String) { get }
  var recTypeLabelText: (label: String, value: String) { get }
}
