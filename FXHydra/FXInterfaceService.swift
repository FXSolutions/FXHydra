//
//  FXInterfaceService.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation
import VK_ios_sdk

class FXInterfaceService :NSObject , VKSdkDelegate , VKSdkUIDelegate {
    
    //
    // Shared instance
    //
    
    var rootNavController = UINavigationController()
    
    private static let shared = FXInterfaceService()
    
    static func sharedManager() -> FXInterfaceService {
        return shared
    }
    
    
    //
    
    override init() {
        super.init()
        
        self.rootNavController.navigationBarHidden = true
        
        //////////////////////////////////////////////////////////////////////
        
        VKSdk.initializeWithAppId("4689635").registerDelegate(self)
        VKSdk.instance().uiDelegate = self
        
        
        VKSdk.wakeUpSession(["audio","status","groups"]) { (state, error) -> Void in
            
            dispatch.async.main({ () -> Void in
                if state == VKAuthorizationState.Authorized {
                    log.debug("VKAuthorizationState === Authroized")
                    self.openAppMainController()
                } else {
                    log.debug("VKAuthorizationState === Not Authroized")
                    self.openAuthController()
                }
            })
            
        }
        
    }
    
    func checkAuth()  {
        
    }
    
    func openAuthController() {
        
        self.rootNavController.pushViewController(FXAuthController(), animated: false)
        
    }
    
    func openAppMainController() {
        
        log.debug("UI Action: === pushRootTabBarController ===")
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let tab = UITabBarController()
            tab.viewControllers = self.getMainNavigations()
            
            self.rootNavController.pushViewController(tab, animated: false)
        }
        
    }
    
    func getMainNavigations() -> [UINavigationController] {
        
        var mainNavigations = [FXNavigationController]()
        
        // main audios
        
        let mainAudiosViewModel = FXAllAudiosViewModel()
        let mainAudiosNav = FXNavigationController(rootViewController: FXAllAudiosController(style: .Plain, bindedViewModel: mainAudiosViewModel))
        
        mainNavigations.append(mainAudiosNav)
        
        // downloads
        
        let downloadsViewModel = FXDownloadsViewModel()
        let downloadsNav = FXNavigationController(rootViewController: FXDownloadsController(style: .Plain, bindedViewModel: downloadsViewModel))
        
        mainNavigations.append(downloadsNav)
        
        // settings
        
        let settingsViewModel = FXSettingsViewModel()
        let settingsNav = FXNavigationController(rootViewController: FXSettingsController(style: .Grouped, bindedViewModel: settingsViewModel))
        
        mainNavigations.append(settingsNav)
        
        
        
        return mainNavigations
    }
    
    func startWorking() {
        
        log.debug("startWorking")
        
        dispatch.async.main { () -> Void in
            
            self.openAppMainController()
            
        }
        
    }
    
    func vkSdkNeedCaptchaEnter(captchaError: VKError!) {
        //
    }
    
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        
        if (result.token != nil) {
            self.startWorking()
        }
        
        log.debug("vkSdkAccessAuthorizationFinishedWithResult : \(result.token)")
    }
    
    func vkSdkAccessTokenUpdated(newToken: VKAccessToken!, oldToken: VKAccessToken!) {
        //
        //self.startWorking()
        log.debug("vkSdkAccessTokenUpdated: \(newToken))")
    }
    
    func vkSdkUserAuthorizationFailed() {
        //
        log.debug("vkSdkUserAuthorizationFailed")
    }
    
    func vkSdkTokenHasExpired(expiredToken: VKAccessToken!) {
        //
        
        log.debug("vkSdkTokenHasExpired: \(expiredToken)")
    }
    
    func vkSdkReceivedNewToken(newToken: VKAccessToken!) {
        log.debug("vkSdkReceivedNewToken: \(newToken)")
        self.startWorking()
    }
    
    func vkSdkShouldPresentViewController(controller: UIViewController!) {
        log.debug("vkSdkShouldPresentViewController")
        
        self.rootNavController.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func vkSdkAcceptedUserToken(token: VKAccessToken!) {
        log.debug("vkSdkAcceptedUserToken")
        
        self.startWorking()
    }
    
    func vkSdkUserDeniedAccess(authorizationError: VKError!) {
        //
        log.debug("vkSdkUserDeniedAccess: \(authorizationError.description)")
    }

}
