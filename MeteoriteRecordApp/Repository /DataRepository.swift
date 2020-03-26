//
//  DataRepository.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 22/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

class DataRepository {
    private let apiClient: APIClient
    private var dbContainer: Container?
    private var mData: (meteoriteInfo: [Meteorite]?,error: APIError?) {
        didSet{
            self.fetchData?()
        }
    }
    var fetchData: (() ->())?
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
        do {
            self.dbContainer = try Container()
        } catch let error {
            Global.printToConsole(message: error.localizedDescription)
        }
    }
    
    /// get the data online and store in the DB, if can not get online data, use the DB data
    func initInfo() {
        
        apiClient.getListInfo(from: .listRecords) { [weak self] result in
            switch result{
            case .success(let meteorites):
                
                self?.mData.meteoriteInfo = meteorites
                DispatchQueue.main.async {
                    self?.saveToDB(meteorites)
                }
            case .failure(let error):
                self?.mData.error = error
                DispatchQueue.main.async {
                    self?.getDbInfo()
                }
            }
        }
    }
    
    func getMeteoriteData() -> (meteoriteInfo: [Meteorite]?,error: APIError?) {
        return mData
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
    
    private func getDbInfo() {
        let results = dbContainer?.values(
            APIMeteorite.self,
            matching:nil
        )
        self.mData.meteoriteInfo = results?.filter { $0.geolocation != nil }
    }
}
