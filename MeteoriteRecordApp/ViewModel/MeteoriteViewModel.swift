//
//  MeteoriteViewModel.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

class MeteoriteViewModel {
    let apiService: APIServiceProtocol
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
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchMeteoriteInfo {[weak self](success, meteorites, error) in
            self?.isLoading = false
            if let error = error {
              self?.alertMessage = error.rawValue
            } else {
              self?.processMeteoriteToCellModel(meteorites: meteorites)
            }
        }
    }
    
    private func processMeteoriteToCellModel(meteorites: [Meteorite]) {
           
           self.meteoriteList = meteorites.sorted(by: { $0.mSize > $1.mSize })
           var cellVMs = [MeteoriteListCellViewModel]()
           for meteorite in self.meteoriteList {
               cellVMs.append(createCellViewModel(meteorite: meteorite))
           }
           self.cellViewModels = cellVMs
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
        if !meteorite.mLocation.coordinates.isEmpty{
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
