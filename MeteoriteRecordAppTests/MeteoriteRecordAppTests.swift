//
//  MeteoriteRecordAppTests.swift
//  MeteoriteRecordAppTests
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import XCTest
@testable import MeteoriteRecordApp

class MeteoriteRecordAppTests: XCTestCase {
    
    var sut: MeteoriteViewModel!
    var mockAPIService: MockApiService!

    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        sut = MeteoriteViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testFetchMeteorite() {
        // Given
        mockAPIService.completeMeteorites = [Meteorite]()

        // When
        sut.initFetch()
    
        // Assert
        XCTAssert(mockAPIService!.isFetchMeteoriteCalled)
    }
    
    func testFetchMeteoriteFail() {
        
        // Given a failed fetch with a certain failure
        let error = APIError.permissionDenied
        
        // When
        sut.initFetch()
        
        mockAPIService.fetchFail(error: error)
        
        // Sut should display predefined error message
        XCTAssertEqual(sut.alertMessage, error.rawValue)
    }
    
    func testCreateCellViewModel() {
        // Given
        let meteorites = DataGenerator().createMeteorite()
        mockAPIService.completeMeteorites = meteorites
        let expect = XCTestExpectation(description: "reload closure triggered")
        sut.reloadTableViewClosure = { () in
            expect.fulfill()
        }
        
        // When
        sut.initFetch()
        mockAPIService.fetchSuccess()
        
        // Number of cell view model is equal to the number of meteorites
        XCTAssertEqual(sut.numberOfCells, meteorites.count)
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
    }
    
    func testLoadingWhileFetching() {
        
        //Given
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Loading status updated")
        sut.updateLoadingStatus = { [weak sut] in
            loadingStatus = sut!.isLoading
            expect.fulfill()
        }
        
        //when fetching
        sut.initFetch()
        
        // Assert
        XCTAssertTrue(loadingStatus)
        
        // When finished fetching
        mockAPIService!.fetchSuccess()
        XCTAssertFalse(loadingStatus)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testUserPressItemWithCoordinates() {
        
        //Given a sut with fetched meteorites
        let indexPath = IndexPath(row: 0, section: 0)
        goToFetchMeteoriteFinished()

        //When
        sut.userPressed(at: indexPath)
        
        //Assert
        XCTAssertTrue(sut.isSegueAllowed)
        XCTAssertNotNil(sut.selectedMeteorite)
        
    }
    
    func testUserPressItemWithoutGeo() {
        
        //Given a sut with fetched meteorites
        let indexPath = IndexPath(row: 7, section: 0)
        goToFetchMeteoriteFinished()
        
        let expect = XCTestExpectation(description: "Alert message is shown")
        sut.showAlertClosure = { [weak sut] in
            expect.fulfill()
            XCTAssertEqual(sut!.alertMessage, "The coordinates is unknown")
        }
        
        //When
        sut.userPressed(at: indexPath)
        
        //Assert
        XCTAssertFalse(sut.isSegueAllowed)
        XCTAssertNil(sut.selectedMeteorite)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testGetCellViewModel() {
        
        //Given a sut with fetched meteorites
        goToFetchMeteoriteFinished()
        
        let indexPath = IndexPath(row: 1, section: 0)
        
        let testMeteorite = sut.sortMeteorites(meteorites: mockAPIService.completeMeteorites)[indexPath.row]

        // When
        let vm = sut.getCellViewModel(at: indexPath)
        
        //Assert
        XCTAssertEqual(vm.titleText, testMeteorite.name)
    }
    
    func testCellViewModel() {
        //Given meteorites
        let meteorite = Meteorite.init(name: "Meteorite", id: "0", nametype: "Valid", recclass: "H6", mass: "750", fall: "Found", year: "1934-01-01T00:00:00.000", reclat: "-30.883330", reclong: "-64.550000", geolocation: Geolocation.init(type:"Point",coordinates:[1.1,2.2]))
        let meteoriteWithoutMass = Meteorite.init(name: "Meteorite", id: "0", nametype: "Valid", recclass: "H6", mass: nil, fall: "Found", year: "1934-01-01T00:00:00.000", reclat: "-30.883330", reclong: "-64.550000", geolocation: Geolocation.init(type:"Point",coordinates:[1.1,2.2]))
        let meteoriteWithoutYear = Meteorite.init(name: "Meteorite", id: "0", nametype: "Valid", recclass: "H6", mass: "750", fall: "Found", year: nil, reclat: "-30.883330", reclong: "-64.550000", geolocation: Geolocation.init(type:"Point",coordinates:[1.1,2.2]))
        
        // When creat cell view model
        let cellViewModel = sut!.createCellViewModel(meteorite: meteorite)
        let cellViewModelWithoutMass = sut!.createCellViewModel(meteorite: meteoriteWithoutMass)
        let cellViewModelWithoutYear = sut!.createCellViewModel(meteorite: meteoriteWithoutYear)

        // Assert the correctness of display information
        XCTAssertEqual(meteorite.name, cellViewModel.titleText)
        XCTAssertEqual(meteorite.date, cellViewModel.dateText)
        XCTAssertEqual(meteorite.mass, cellViewModel.sizeText)
        

        XCTAssertEqual(cellViewModelWithoutMass.sizeText, "UNKNOWN")
        XCTAssertEqual(cellViewModelWithoutYear.dateText, "UNKNOWN")
    }
}

//MARK: State control
extension MeteoriteRecordAppTests {
    private func goToFetchMeteoriteFinished() {
        mockAPIService.completeMeteorites = DataGenerator().createMeteorite()
        sut.initFetch()
        mockAPIService.fetchSuccess()
    }
}

class MockApiService: APIServiceProtocol {
    var isFetchMeteoriteCalled = false
    
    var completeMeteorites: [Meteorite] = [Meteorite]()
    var completeClosure: ((Bool, [Meteorite], APIError?) -> ())!
    
    func fetchMeteoriteInfo(complete: @escaping (Bool, [Meteorite], APIError?) -> ()) {
         isFetchMeteoriteCalled = true
         completeClosure = complete
    }
    
    func fetchSuccess() {
        completeClosure(true, completeMeteorites, nil)
    }
    
    func fetchFail(error: APIError?) {
        completeClosure(false, completeMeteorites, error)
    }
    
}

class DataGenerator {
    func createMeteorite() -> [Meteorite] {
        let path = Bundle.main.path(forResource: "ApiData", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let meteorites = try! decoder.decode([Meteorite].self, from: data)
        return meteorites
    }
}
