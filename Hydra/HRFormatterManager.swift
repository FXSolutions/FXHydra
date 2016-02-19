//
//  HRFormatterManager.swift
//  Hydra
//
//  Created by kioshimafx on 2/19/16.
//  Copyright © 2016 kioshimafx. All rights reserved.
//

import UIKit

class HRFormatterManager {
    
    static let sharedInstance = HRFormatterManager()
    
    func getBitrate(audio:HRAudioItemModel,completition:(Int) -> ()) {
        
        let audioURL = NSURL(string: "\(audio.audioNetworkURL)")!
        
        let request1: NSMutableURLRequest = NSMutableURLRequest(URL: audioURL)
        request1.HTTPMethod = "HEAD"
        
        var response : NSURLResponse?
        
        do {
            
            try NSURLConnection.sendSynchronousRequest(request1, returningResponse: &response)
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                let size = httpResponse.expectedContentLength
                let kbit = size/128;//calculate bytes to kbit
                let kbps = ceil(round(Double(kbit)/Double(audio.duration))/16)*16
                
                print("kbps === \(kbps)")
                
                audio.bitrate = Int(kbps)
                
                completition(Int(kbps))
            }
            
        } catch (let e) {
            print(e)
        }
        
        
    }

}
