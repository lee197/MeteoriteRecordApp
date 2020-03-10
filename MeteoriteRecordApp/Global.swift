//
//  Global.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 07/03/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
struct Global{
    
    static func printToConsole(message : String) {
        #if DEBUG
        print(message)
        #endif
    }
}

