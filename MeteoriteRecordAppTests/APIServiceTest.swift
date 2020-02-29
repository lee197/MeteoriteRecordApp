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

    var sut: APIService?
    
    override func setUp() {
        super.setUp()
        sut = APIService()
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

        sut.fetchMeteoriteInfo(complete: { (success, meteorites, error) in
            expect.fulfill()
            XCTAssertEqual(meteorites.count, 10)
            for meteorite in meteorites {
                XCTAssertNotNil(meteorite.id)
            }
        })

        wait(for: [expect], timeout: 3.1)
    }
    
}
