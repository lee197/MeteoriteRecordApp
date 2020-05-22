//
//  APIClient.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 12/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

class APIClient: APIClientProtocol {
    
    func getListInfo(from type: MeteoriteRecord, completion: @escaping (Result<[APIMeteorite], APIError>) -> Void){
        fetchInfo(type, decode: {
            json -> [APIMeteorite]? in
            guard let result = json as? [APIMeteorite] else { return  nil }
            return result
        }, complete: completion)
    }
}
