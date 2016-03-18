//
//  FXAudioItemModel.swift
//  FXHydra
//
//  Created by kioshimafx on 3/16/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXAudioItemModel {
    
    var artist : String!
    var title  : String!
    var audioNetworkURL : String!
    var audioLocalURL   : String!
    var duration : Int!
    var audioID : Int!
    var ownerID : Int!
    var downloadState : Int!
    var globalState : Int!
    var lyrics_id : Int!
    var genre_id : Int!
    var downloadedTime : Int!
    var bitrate : Int = 0
    
    init() {
        self.audioID = -1
    }
    
    init(json : JSON) {
        
        self.title              = json["title"].stringValue
        self.audioID            = json["id"].intValue
        self.lyrics_id          = json["lyrics_id"].intValue
        self.ownerID            = json["owner_id"].intValue
        self.artist             = json["artist"].stringValue
        self.duration           = json["duration"].intValue
        self.genre_id           = json["genre_id"].intValue
        self.audioNetworkURL    = json["url"].stringValue
        
    }
    
    
    func getBitrate(completition:(Int) -> ()) {
        
        /////
        
        dispatch.async.global { () -> Void in
            
            if self.bitrate > 0 {
                dispatch.async.main({ () -> Void in
                    completition(self.bitrate)
                })
                
                // stop
                
                return
            }
            
            
            let audioURL = NSURL(string: "\(self.audioNetworkURL)")!
            
            let request1: NSMutableURLRequest = NSMutableURLRequest(URL: audioURL)
            request1.HTTPMethod = "HEAD"
            
            var response : NSURLResponse?
            
            do {
                
                try NSURLConnection.sendSynchronousRequest(request1, returningResponse: &response)
                
                if let httpResponse = response as? NSHTTPURLResponse {
                    
                    let size = httpResponse.expectedContentLength
                    let kbit = size/128;//calculate bytes to kbit
                    let kbps = ceil(round(Double(kbit)/Double(self.duration))/16)*16
                    
                    //print("kbps === \(kbps)")
                    
                    self.bitrate = Int(kbps)
                    
                    ////
                    
                    dispatch.async.main({ () -> Void in
                        completition(Int(kbps))
                    })
                    
                    ////
                    
                }
                
            } catch (let e) {
                print(e)
            }
            
        }
        
        
        
    }
    
    
    func getDurationString() -> String {
        
        let min = Int(floor(Double(self.duration) / 60))
        let sec = Int(floor(Double(self.duration) % 60))
        
        if (sec < 10) {
            return "\(min):0\(sec)"
        } else {
            return "\(min):\(sec)"
        }
        
    }

}
