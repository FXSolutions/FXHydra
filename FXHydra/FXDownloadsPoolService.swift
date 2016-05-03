//
//  FXDownloadsPoolService.swift
//  FXHydra
//
//  Created by kioshimafx on 4/10/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation
import Just
import SwiftFilePath

class FXDownloadsPoolService {
    
    //
    // Shared instance
    //
    
    private static let shared = FXDownloadsPoolService()
    
    static func sharedManager() -> FXDownloadsPoolService {
        return shared
    }
    
    func downloadAudioOnLocalStorage(audio_model:FXAudioItemModel) {
        
        Just.get(audio_model.audioNetworkURL, asyncProgressHandler: { (progress) in
            
            log.debug("::: progress donwload : \(progress.bytesProcessed) \(progress.bytesExpectedToProcess)")
            
            }) { (result) in
                
                log.debug("::: result \(result)")
                
                if result.ok == true {
                    log.debug("zaebok")
                    
                    if Path.homeDir["FXHydra"].exists == false {
                        
                        let hydarDir = Path.homeDir["FXHydra"]
                        hydarDir.mkdir()
                        
                        let mp3File = Path.homeDir["FXHydra"]["audioid_\(audio_model.audioID).mp3"]
                        let path = "audioid_\(audio_model.audioID).mp3"
                        
                        mp3File.writeData(result.content!)
                        
                        
                        log.debug("::: save in path: \(path) :::")
                        
                        audio_model.audioLocalURL = path
                        
                        FXDatabaseService.sharedManager().saveDownloadModel(audio_model, cb: { (done) in
                            log.debug("::: audio model saved :::")
                            
                            dispatch.async.main({
                                FXSignalsService.sharedManager().updateAfterDownload.fire(true)
                            })
                            
                        })
                        
                    
                    } else {
                        
                        let mp3File = Path.homeDir["FXHydra"]["audioid_\(audio_model.audioID).mp3"]
                        mp3File.writeData(result.content!)
                        
                        let path = "audioid_\(audio_model.audioID).mp3"
                        
                        log.debug("::: save in path: \(path) :::")
                        
                        audio_model.audioLocalURL = path
                        
                        FXDatabaseService.sharedManager().saveDownloadModel(audio_model, cb: { (done) in
                            log.debug("::: audio model saved :::")
                            
                            dispatch.async.main({
                                FXSignalsService.sharedManager().updateAfterDownload.fire(true)
                            })
                            
                        })
                        
                    }
                    

                    
                    
                } else {
                    log.debug("pizda :(")
                }
                
        }
        
        
    }
    
    ///

}
