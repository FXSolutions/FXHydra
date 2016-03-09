//
//  FXApiManager.swift
//  FXHydra
//
//  Created by kioshimafx on 3/16/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation

class FXApiManager {

    //
    // Shared instance
    //
    
    private static let shared = FXApiManager()
    
    static func sharedManager() -> FXApiManager {
        return shared
    }
    
    
}
