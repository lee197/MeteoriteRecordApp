//
//  EndPoint.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 12/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//


import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url,cachePolicy: .reloadIgnoringLocalCacheData)
    }
}

enum MeteoriteRecord {
    
    case listRecords
}

extension MeteoriteRecord: Endpoint {
    
    var base: String {
        return Environment.development.baseUrl
    }
    
    var path: String {
        switch self {
        case .listRecords: return "/resource/y77d-th95.json"
        }
    }
}








