//
//  FXSignalsService.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation

class FXSignalsService {
    
    //
    // Shared instance
    //
    
    private static let shared = FXSignalsService()
    
    static func sharedManager() -> FXSignalsService {
        return shared
    }
    
    let appChangeStateToBackground = Signal<(Bool!)>()
    
    
}
