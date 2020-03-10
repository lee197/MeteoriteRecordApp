//
//  MeteoriteViewModel.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

final class MeteoriteViewModel {
    private let apiService: APIClientProtocol
    private var meteoriteList = [Meteorite]()
    private var cellViewModels: [MeteoriteListCellViewModel] = [MeteoriteListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    var numberOfCells: Int {
        return cellViewModels.count
    }
    var isSegueAllowed: Bool = false
    var selectedMeteorite: Meteorite?
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    let sizeAbsence = Double(APINULL.noSize.rawValue)
    
    init(apiService: APIClientProtocol = APIClient()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true

        apiService.fetchInfo(){ [weak self] result in
            self?.isLoading = false
            switch result{
            case .success(let meteorites):
                self?.processMeteoriteToCellModel(meteorites: meteorites)
            case .failure(let error):
                self?.alertMessage = error.localizedDescription
            }
        }
    }
    
    private func processMeteoriteToCellModel(meteorites: [Meteorite]) {
        
        self.meteoriteList = meteorites.sorted(by: { $0.mSize > $1.mSize })
        self.cellViewModels = self.meteoriteList.map { createCellViewModel(meteorite: $0) }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> MeteoriteListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel(meteorite:Meteorite) -> MeteoriteListCellViewModel {
        var meteoriteMass = "UNKNOWN"
        var meteoriteDate = "UNKNOWN"
        //ToFix
        if meteorite.mSize != sizeAbsence {
            meteoriteMass = String(meteorite.mSize)
        }
        if meteorite.mDate != APINULL.noYear.rawValue {
            meteoriteDate = meteorite.mDate
        }
        
        return MeteoriteListCellViewModel(  titleText: meteorite.mName,
                                            sizeText: meteoriteMass,
                                            dateText: meteoriteDate )
    }
}

extension MeteoriteViewModel {
    func userPressed( at indexPath: IndexPath ) {
        let meteorite = self.meteoriteList[indexPath.row]
        if !meteorite.mLocation.location.isEmpty{
            self.isSegueAllowed = true
            self.selectedMeteorite = meteorite
        }else{
            self.isSegueAllowed = false
            self.selectedMeteorite = nil
            self.alertMessage = "The coordinates is unknown"
        }
    }
}

struct MeteoriteListCellViewModel {
    let titleText: String
    let sizeText: String
    let dateText: String
}
