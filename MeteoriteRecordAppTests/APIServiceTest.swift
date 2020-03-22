//
//  APIServiceTest.swift
//  MeteoriteRecordAppTests
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import XCTest
@testable import MeteoriteRecordApp

class APIServiceTest: XCTestCase {
    
    var sut: APIClient?
    
    override func setUp() {
        super.setUp()
        sut = APIClient()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchMeteoriteInfo() {
        
        // Given a apiservice
        let sut = self.sut!
        
        // When fetch info
        let expect = XCTestExpectation(description: "callback")
        sut.fetchInfo(.listRecords){ result in
            expect.fulfill()
            switch result{
            case .success(let meteorites):
                XCTAssertEqual(meteorites.count, 1000)
                for meteorite in meteorites {
                    XCTAssertNotNil(meteorite.mName)
                }
            case .failure(_): break
            }
        }
        
    }
    
}
