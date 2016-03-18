//
//  FXAllAudiosViewModel.swift
//  FXHydra
//
//  Created by kioshimafx on 3/11/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation

class FXAllAudiosViewModel {
    
    var audiosArray = [FXAudioItemModel]()
    
    func getAudios(competition:(Bool) -> ()) {
        
        FXApiManager.sharedManager().vk_getAudiosWithOffset(0, count: 50) { (arrayAudios) -> () in
            self.audiosArray = arrayAudios
            competition(true)
        }
        
    }
    
    deinit {
        
        log.info("deinit ::: FXAllAudiosViewModel")
        
    }
    

}
