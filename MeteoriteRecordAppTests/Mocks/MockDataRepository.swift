//
//  MockDataRepository.swift
//  MeteoriteRecordAppTests
//
//  Created by 李祺 on 31/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
@testable import MeteoriteRecordApp

class MockDataRepository {
    
    var shouldReturnError = false
    var isFetchMeteoriteCalled = false
    var completedMeteorites = [Meteorite]()
    var completeClosure: ((Result<[Meteorite], APIError>) -> ())!
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError:Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchSuccess() {
        completeClosure(.success(completedMeteorites))
    }
    
    func fetchFail(error: APIError) {
        completeClosure(.failure(error))
    }
    
    func reset(){
        shouldReturnError = false
        isFetchMeteoriteCalled = false
    }
}

extension MockDataRepository: DataRepositoryProtocol {
    func initFetch(complete completionHandler: @escaping (Result<[Meteorite], APIError>) -> Void) {
        isFetchMeteoriteCalled = true
        completeClosure = completionHandler
    }
}

class MockDataGenerator {
    func mockMeteoriteData() -> [Meteorite] {
        let path = Bundle.main.path(forResource: "ApiTestData", ofType: "json")!
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let meteorites = try? decoder.decode([APIMeteorite].self, from: data!)
        return meteorites!
    }
}
