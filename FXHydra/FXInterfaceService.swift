//
//  FXInterfaceService.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation

class FXInterfaceService {
    
    //
    // Shared instance
    //
    
    private static let shared = FXInterfaceService()
    
    static func sharedManager() -> FXInterfaceService {
        return shared
    }
    
    
    //
    
    var authController = FXAuthController()

}
