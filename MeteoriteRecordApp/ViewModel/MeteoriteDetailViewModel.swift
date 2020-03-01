//
//  MeteoriteDetailViewModel.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 28/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

class MeteoriteDetailViewModel {
    
    private let meteorite:Meteorite
    
    init(meteorite:Meteorite) {
        self.meteorite = meteorite
    }
    
    func getMeteorite() -> Meteorite{
        return meteorite
    }
}
