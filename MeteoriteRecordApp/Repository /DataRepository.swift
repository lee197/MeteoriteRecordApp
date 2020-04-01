//
//  DataRepository.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 22/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

protocol DataRepositoryProtocol {
    func initFetch(complete completion: @escaping (Result<[Meteorite], APIError>) -> Void)
}

class DataRepository {
    
    var fetchData: (() -> ())?
    
    private let apiClient: APIClient
    private var dbContainer: Container?
    
    init(apiClient: APIClient = APIClient()) {
        
        self.apiClient = apiClient
        do {
            self.dbContainer = try Container()
        } catch let error {
            Global.printToConsole(message: error.localizedDescription)
        }
    }
    
    private func saveToDB(_ meteorites: [APIMeteorite]) {
        
        do {
            try dbContainer?.write { transaction in
                //TODO: Too much CPU, 13% CPU incraesed
                meteorites.forEach { item in
                    transaction.add(item, update: .modified)
                }
            }
        } catch (let error) {
            Global.printToConsole(message: error.localizedDescription)
        }
    }
    
    private func getDbInfo(complete completion: @escaping (Result<[Meteorite], APIError>) -> Void) {
        
        let results = dbContainer?.values(
            APIMeteorite.self,
            matching:nil
        )
        completion(.success(results?.filter { $0.geolocation != nil } ?? []))
    }
}

extension DataRepository:DataRepositoryProtocol {
    
    func initFetch(complete completion: @escaping (Result<[Meteorite], APIError>) -> Void) {
        
        apiClient.getListInfo(from: .listRecords) { [weak self] result in
            switch result{
                
            case .success(let meteorites):
                completion(.success(meteorites))
                DispatchQueue.main.async {
                    self?.saveToDB(meteorites)
                }
                
            case .failure(let error):
                completion(.failure(error))
                DispatchQueue.main.async {
                    self?.getDbInfo{ result in
                        completion(.success( try! result.get()))
                    }
                }
            }
        }
    }
}
