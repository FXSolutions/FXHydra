//
//  FXDatabaseService.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation

class FXDatabaseService {
    
    //
    // Shared instance
    //
    
    private static let shared = FXDatabaseService()
    
    static func sharedManager() -> FXDatabaseService {
        return shared
    }
    
    init() {
        self.getAllSqliteInfo()
    }
    
    
    /*
    
    public var SQLITE_VERSION: String { get }
    public var SQLITE_VERSION_NUMBER: Int32 { get }
    public var SQLITE_SOURCE_ID: String { get }
    
    */
    
    func getAllSqliteInfo() {
        
        log.info("Init ::: TMDatabaseManager")
        
    }

}
