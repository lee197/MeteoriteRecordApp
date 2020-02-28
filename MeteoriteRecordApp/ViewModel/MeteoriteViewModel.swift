//
//  MeteoriteViewModel.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

class MeteoriteViewModel{
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

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchMeteoriteInfo {[weak self](success, meteorites, error) in
            guard let weakSelf = self else{
               return
            }
            
            weakSelf.isLoading = false
            if let error = error {
              weakSelf.alertMessage = error.rawValue
            } else {
              weakSelf.processFetchedMeteorite(meteorites: meteorites)
            }
        }
    }
    
    private func processFetchedMeteorite(meteorites: [Meteorite]) {
           //TODO
           self.meteoriteList = sortMeteorites(meteorites:meteorites)
           var vms = [MeteoriteListCellViewModel]()
           for meteorite in self.meteoriteList {
               vms.append(createCellViewModel(meteorite: meteorite))
           }
           self.cellViewModels = vms
    }
    //TODO
    func sortMeteorites(meteorites: [Meteorite]) -> [Meteorite]{
         return meteorites.sorted(by: { Double($0.mass!)! > Double($1.mass!)! })
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> MeteoriteListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel(meteorite:Meteorite) -> MeteoriteListCellViewModel {
         var meteoriteMass = "UNKNOWN"
         var meteoriteDate = "UNKNOWN"
         
         if let mass = meteorite.mass {
            meteoriteMass = mass
         }
        
         if let _ = meteorite.year {
            meteoriteDate = meteorite.date
          }

          return MeteoriteListCellViewModel( titleText: meteorite.name,
                                             sizeText: meteoriteMass,
                                             dateText: meteoriteDate)
    }
}

extension MeteoriteViewModel{
    func userPressed( at indexPath: IndexPath ){
        let meteorite = self.meteoriteList[indexPath.row]
        if let _ = meteorite.geolocation {
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
