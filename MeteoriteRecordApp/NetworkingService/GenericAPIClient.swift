//
//  APIService.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}

protocol APIClientProtocol {
    func fetchInfo<T: Decodable>(_ type: MeteoriteRecord, decode: @escaping (Decodable) -> T?, complete:@escaping (Result<T,APIError> )->())
}

extension APIClientProtocol {
    func fetchInfo<T: Decodable>(_ type: MeteoriteRecord, decode: @escaping (Decodable) -> T?, complete completion: @escaping (Result<T, APIError>) -> Void) {
        
        URLSession.shared.dataTask(with: type.request) { data, response, error in
            
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
                let value = try decoder.decode(T.self, from: data)
                if let result = decode(value){
                    completion(.success(result))
                }
            }catch{
                completion(.failure(.dataDecodingError))
            }
            
        }.resume()
    }
}

