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
    var mockDataRepository: MockDataRepository!
    
    override func setUp() {
        super.setUp()
        mockDataRepository = MockDataRepository()
        sut = MeteoriteViewModel(dataRepo: mockDataRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockDataRepository = nil
        super.tearDown()
    }
    
    func testFetchMeteorite() {
        
        // Given
        mockDataRepository.completedMeteorites = [Meteorite]()
        
        // When
        sut.initFetch()
        
        // Assert
        XCTAssert(mockDataRepository.isFetchMeteoriteCalled)
    }
    
    func testFetchMeteoriteFail() {
        
        // Given a failed fetch with a certain failure
        let error = APIError.clientError
        let alert = UserAlert.userError
        
        // When
        sut.initFetch()
        mockDataRepository.fetchFail(error: error)
        
        // Sut should display predefined error message
        XCTAssertEqual(sut.alertMessage, alert.rawValue)
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
        mockDataRepository!.fetchSuccess()
        XCTAssertFalse(loadingStatus)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testCreateCellViewModel() {
        
        // Given
        let expect = XCTestExpectation(description: "reload closure triggered")
        var meteoriteList = [Meteorite]()
        sut.reloadTableViewClosure = { [weak self] () in
            expect.fulfill()
            meteoriteList = self?.sut.meteoriteList ?? []
        }
        
        // When
        sut.initFetch()
        mockDataRepository.fetchSuccess()
        
        // Number of cell view model is equal to the number of meteorites
        XCTAssertEqual(sut.numberOfCells, meteoriteList.count)
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
    }
    
    func testGetCellViewModel() {

        //Given a sut with fetched meteorites
        goToFetchMeteoriteFinished()
        let indexPath = IndexPath(row: 1, section: 0)
        let testMeteorite = mockDataRepository.completedMeteorites.sorted(by: { $0.mSize > $1.mSize })[indexPath.row]
        
        // When
        let vm = sut.getCellViewModel(at: indexPath)

        //Assert
        XCTAssertEqual(vm.titleText, testMeteorite.mName)
    }
    
    func testCellViewModel() {
        
        //Given APIMeteorite
        let meteorite:Meteorite = APIMeteorite(name: "Meteorite",
                                               id: "0",
                                               nametype: "Valid",
                                               recclass: "H6",
                                               mass: "750.0",
                                               fall: "Found",
                                               year: "1934-01-01T00:00:00.000",
                                               reclat: "-30.883330",
                                               reclong: "-64.550000",
                                               geolocation: Geolocation.init(type:"Point",
                                                                             coordinates:[1.1,2.2]))
        let meteoriteWithoutMass = APIMeteorite(name: "Meteorite",
                                                id: "0",
                                                nametype: "Valid",
                                                recclass: "H6",
                                                mass: nil,
                                                fall: "Found",
                                                year: "1934-01-01T00:00:00.000",
                                                reclat: "-30.883330",
                                                reclong: "-64.550000",
                                                geolocation: Geolocation.init(type:"Point",
                                                                              coordinates:[1.1,2.2]))
        let meteoriteWithoutYear = APIMeteorite(name: "Meteorite",
                                                id: "0",
                                                nametype: "Valid",
                                                recclass: "H6",
                                                mass: "750",
                                                fall: "Found",
                                                year: nil,
                                                reclat: "-30.883330",
                                                reclong: "-64.550000",
                                                geolocation: Geolocation.init(type:"Point",
                                                                              coordinates:[1.1,2.2]))
        
        // When creat cell view model
        let cellViewModel = sut!.createCellViewModel(meteorite: meteorite)
        let cellViewModelWithoutMass = sut!.createCellViewModel(meteorite: meteoriteWithoutMass)
        let cellViewModelWithoutYear = sut!.createCellViewModel(meteorite: meteoriteWithoutYear)
        
        // Assert the correctness of display information
        XCTAssertEqual(meteorite.mName, cellViewModel.titleText)
        XCTAssertEqual(meteorite.mDate, cellViewModel.dateText)
        XCTAssertEqual(String(meteorite.mSize) + " KG", cellViewModel.sizeText)
        
        XCTAssertEqual(cellViewModelWithoutMass.sizeText, "UNKNOWN")
        XCTAssertEqual(cellViewModelWithoutYear.dateText, "UNKNOWN")
    }
    
    func testUserPressItemWithGeo() {
        
        //Given a sut with fetched meteorites
        let indexPath = IndexPath(row: 0, section: 0)
        goToFetchMeteoriteFinished()
        sut.initFetch()
        //When
        sut.userPressed(at: indexPath)
        
        //Assert
        XCTAssertTrue(sut.isSegueAllowed)
        XCTAssertNotNil(sut.selectedMeteorite)
        
    }
    
    func testUserPressItemWithoutGeo() {
        
        //Given a sut with fetched meteorites
        let indexPath = IndexPath(row: 6, section: 0)
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
    
    
}

//MARK: State control
extension MeteoriteRecordAppTests {
    private func goToFetchMeteoriteFinished() {
        mockDataRepository.completedMeteorites = MockDataGenerator().mockMeteoriteData()
        sut.initFetch()
        mockDataRepository.fetchSuccess()
    }
}





