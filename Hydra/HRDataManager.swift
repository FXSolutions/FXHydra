//
//  HRDataManager.swift
//  Hydra
//
//  Created by Evgeny Abramov on 8/2/15.
//  Copyright © 2015 Evgeny Abramov. All rights reserved.
//

import Foundation

class HRDataManager: NSObject {
    
    // ##### singleton #####
    static let sharedInstance = HRDataManager()
    
    var currentUserModel : HRUserModel!
    let currentUserInfo = Signal<(HRUserModel!)>()
    
    
    func getCurrentUserInfo() {
        
        let getUserInfo = VKRequest(method: "users.get", andParameters: ["fields":"photo_200","name_case":"Nom"], andHttpMethod: "GET")
        
        getUserInfo.executeWithResultBlock({ (response) -> Void in
            
            let jsonItems = response.json as! Array<Dictionary<String,AnyObject>>
            let json = jsonItems[0]
            let userInfo = HRUserModel(json: JSON(json))
            self.currentUserInfo.fire(userInfo)
            
            }, errorBlock: { (error) -> Void in
                // error
                print(error)
        })
        
        
    }
    
}
