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
    
    static let sharedInstance = HRDownloadManager()
    
    func downloadAudio(model:HRAudioItemModel,progress:(Float) -> () ) {
        
        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        
        Alamofire.download(.GET, model.audioNetworkURL, destination: destination).progress { (one, two, three) -> Void in
                            let loadedData:Float = Float(two)
                            let allData:Float = Float(three)
            
                            progress(loadedData/allData)
        }.response { (_, _, _, _) -> Void in
            let currentFileName = NSURL(string:model.audioNetworkURL)?.lastPathComponent

            model.audioLocalURL = currentFileName
            HRDatabaseManager.sharedInstance.saveInDB(model)
        }
//        Alamofire.download(.GET, model.audioNetworkURL) { (temporaryURL, response) -> NSURL in
//            
//            
//            return temporaryURL
//            
//            }.progress { (one, two, three) -> Void in
//                
//                let loadedData:Float = Float(two)
//                let allData:Float = Float(three)
//                
//                progress(loadedData/allData)
//        }.response { (_, _, resultData, _) -> Void in
//            let currentFileName = NSURL(string:model.audioNetworkURL)?.lastPathComponent
//            var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//            let docsDir: AnyObject = dirPaths[0]
//            let soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName!)
//            
//            let fileManager = NSFileManager()
//            if fileManager.createFileAtPath(soundFilePath, contents: resultData, attributes: nil) {
//                log.debug("audio saved on device! audio path = \(soundFilePath)")
//                
//                model.audioLocalURL = currentFileName
//                HRDatabaseManager.sharedInstance.saveInDB(model)
//                
//            }
//        }
//
        /*
        Alamofire.download(.GET, urlToCall, { (temporaryURL, response) in
        
        if let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as? NSURL {
        
        fileName = response.suggestedFilename!
        finalPath = directoryURL.URLByAppendingPathComponent(fileName!)
        return finalPath!
        }
        
        return temporaryURL
        })
        .response { (request, response, data, error) in
        
        if error != nil {
        println("REQUEST: \(request)")
        println("RESPONSE: \(response)")
        }
        
        if finalPath != nil {
        doSomethingWithTheFile(finalPath!, fileName: fileName!)
        }
        }
        */
        
    }

}
