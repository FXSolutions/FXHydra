//
//  FXFMDBString.swift
//  FXHydra
//
//  Created by kioshimafx on 4/10/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation

extension String {
    
    //.stringByReplacingOccurrencesOfString("'", withString: "''")
    
    func sqlString() -> String {
        return self.stringByReplacingOccurrencesOfString("'", withString: "''")
    }
    
    
}