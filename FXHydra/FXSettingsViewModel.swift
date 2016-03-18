//
//  FXSettingsViewModel.swift
//  FXHydra
//
//  Created by kioshimafx on 3/11/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation
import VK_ios_sdk

class FXSettingsViewModel {
    
    func logOut() {
        
        VKSdk.forceLogout()
        FXInterfaceService.sharedManager().logOut()
        
    }

}
