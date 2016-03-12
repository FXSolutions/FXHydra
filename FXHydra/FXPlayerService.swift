//
//  FXPlayerService.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation

class FXPlayerService {

    //
    // Shared instance
    //
    
    private static let shared = FXPlayerService()
    
    static func sharedManager() -> FXPlayerService {
        return shared
    }
    
}
