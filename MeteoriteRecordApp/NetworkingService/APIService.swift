//
//  APIService.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchMeteoriteInfo( complete: @escaping ( _ success: Bool, _ meteorites: [Meteorite], _ error: APIError? )->() )
}

struct APIService: APIServiceProtocol {
    func fetchMeteoriteInfo(complete: @escaping (Bool, [Meteorite], APIError?) -> ()) {
         DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
         let path = Bundle.main.path(forResource: "ApiTestData", ofType: "json")!
         let data = try? Data(contentsOf: URL(fileURLWithPath: path))
         let decoder = JSONDecoder()
         decoder.dateDecodingStrategy = .iso8601
         let meteorites = try? decoder.decode([APIMeteorite].self, from: data!)
         complete( true, meteorites!, nil )
          }
        }
    
//    func fetchMeteoriteInfo(complete: @escaping (Bool, [Meteorite], APIError?) -> ()) {
//        AF.request("https://data.nasa.gov/resource/y77d-th95.json").validate().responseDecodable(of: [APIMeteorite].self) { (response) in
//        guard let meteorites = response.value else {
////           print(response.error?.errorDescription)
//           return }
//        complete( true, meteorites, nil )
//        }
//    }
}

