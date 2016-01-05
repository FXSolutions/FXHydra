//
//  HRDataManager.swift
//  Hydra
//
//  Created by Evgeny Abramov on 8/2/15.
//  Copyright © 2015 Evgeny Abramov. All rights reserved.
//

import Foundation
import VK_ios_sdk

class HRDataManager {
    
    // ##### singleton #####
    static let sharedInstance = HRDataManager()
    
    var currentUserModel : HRUserModel!
    let currentUserInfo = Signal<(HRUserModel!)>()
    
    // all downloaded ids
    var arrayWithDownloadedIds = [Int]()

    func getCurrentUserInfo() {
        
        let getUserInfo = VKRequest(method: "users.get", andParameters: ["fields":"photo_200","name_case":"Nom"])
        
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
    
    func getAllDownloadedIdsFromDb(completion: (Bool) -> ()) {
        HRDatabaseManager.sharedInstance.getAllDownloadsIds { (idsArray) -> () in
            self.arrayWithDownloadedIds = idsArray
            completion(true)
        }
        
    }
    
}
