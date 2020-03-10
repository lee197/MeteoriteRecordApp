//
//  APIService.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

enum APIError:  String, Error {
    case clientError = "Permission Denied"
    case serverError = "Server error"
    case noData = "Invalid data"
    case dataDecodingError
}

protocol APIClientProtocol {
    func fetchInfo( complete:@escaping (Result<[Meteorite],APIError> )->())
}

struct APIClient: APIClientProtocol {
    func fetchInfo(complete completion: @escaping (Result<[Meteorite], APIError>) -> Void) {
        guard let url = Environment.production.baseUrl else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            guard error == nil else {
                completion(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([APIMeteorite].self, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(.dataDecodingError))
            }
                        
        }.resume()
    }
}

