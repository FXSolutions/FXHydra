//
//  HRDownloadManager.swift
//  Hydra
//
//  Created by Evgeny Abramov on 9/14/15.
//  Copyright © 2015 Evgeny Abramov. All rights reserved.
//

import Foundation
import Alamofire

class HRDownloadManager {
    
    var progressStore = Dictionary<String,AnyObject>()
    
    static let sharedInstance = HRDownloadManager()
    
    func downloadAudio(model:HRAudioItemModel,progress:(Float) -> () ) {
        
        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        
        //bytesWritten, totalBytesWritten, totalBytesExpectedToWrite
        
        Alamofire.download(.GET, model.audioNetworkURL, destination: destination).progress { (one, two, three) -> Void in
                            let loadedData:Float = Float(two)
                            let allData:Float = Float(three)
            
                            progress(loadedData/allData)
            
        }.response { (_, _, _, _) -> Void in
            let currentFileName = NSURL(string:model.audioNetworkURL)?.lastPathComponent

            model.audioLocalURL = currentFileName
            model.downloadedTime = Int(NSDate().timeIntervalSince1970)
            HRDatabaseManager.sharedInstance.saveInDB(model)
        }
        
        
        
        
    }

}
