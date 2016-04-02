//
//  FXDataService.swift
//  FXHydra
//
//  Created by kioshimafx on 4/10/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation

class FXDataService {
    
    //
    // Shared instance
    //
    
    var allDownloads = Dictionary<String,AnyObject>()
    
    private static let shared = FXDataService()
    
    static func sharedManager() -> FXDataService {
        return shared
    }
    
    func loadAllDownloads(cb:(Bool) -> ()) {
        
        
        FXDatabaseService.sharedManager().getAllDownloadsFromDB { (downloadsArray) in
            
            for audioModel in downloadsArray {
                
                self.allDownloads["\(audioModel.audioID)"] = NSNumber(integer: audioModel.audioID)
                
            }
            
            cb(true)
            
        }
        
        
    }
    
    func checkAudioIdInDownloads(audio_id:Int) -> Bool {
        
        if (self.allDownloads["\(audio_id)"] != nil) {
            return true
        } else {
            return false
        }
        
    }
    
    
    ///

}
