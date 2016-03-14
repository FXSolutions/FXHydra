//
//  FXPlayerService.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation
import StreamingKit
import AVFoundation

class FXPlayerService {

    //
    // Shared instance
    //
    
    let audioPlayer = STKAudioPlayer()
    
    private static let shared = FXPlayerService()
    
    static func sharedManager() -> FXPlayerService {
        return shared
    }
    
    init() {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            try audioSession.setActive(true)
            
        } catch {
            log.error("audio session register error")
        }
        
    }
    
    
    func startPlayAudioModel(model:FXAudioItemModel) {
        
        self.audioPlayer.play(model.audioNetworkURL)
    
    }
    
}
