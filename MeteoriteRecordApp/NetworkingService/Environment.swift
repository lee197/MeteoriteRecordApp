//
//  Environment.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 07/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

enum Environment {
    
    case development
    case staging
    case production
    
    var isDevelopment: Bool { return self == .development }
    var isStaging: Bool { return self == .staging }
    var isProduction: Bool { return self == .production }
    
    var baseUrl:URL?{
        switch self {
        case .development:
            return URL(string: "https://data.nasa.gov/resource/y77d-th95.json")
        case .staging:
            return URL(string: "https://data.nasa.gov/resource/y77d-th95.json")
        case .production:
            return URL(string: "https://data.nasa.gov/resource/y77d-th95.json")
        }
    }
}
