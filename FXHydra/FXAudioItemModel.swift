//
//  FXAudioItemModel.swift
//  FXHydra
//
//  Created by kioshimafx on 3/16/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXAudioItemModel {
    
    var audioID : Int!
    var artist : String!
    var title  : String!
    var audioNetworkURL : String!
    var audioLocalURL   : String!
    var duration : Int!
    var ownerID : Int!
    var lyrics_id : Int!
    var genre_id : Int!
    
    var downloadState : Int!
    var globalState : Int!
    var downloadedTime : Int!
    var bitrate : Int = 0
    
    init() {
        self.audioID = -1
    }
    
    init(json : JSON) {
        
        self.audioID            = json["id"].intValue
        self.artist             = json["artist"].stringValue
        self.title              = json["title"].stringValue
        self.lyrics_id          = json["lyrics_id"].intValue
        self.audioNetworkURL    = json["url"].stringValue
        self.ownerID            = json["owner_id"].intValue
        self.duration           = json["duration"].intValue
        self.genre_id           = json["genre_id"].intValue
        
    }
    
    
    func getBitrate(completition:(Int) -> ()) {
        
        /////
        
        dispatch.async.global { () -> Void in
            
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
                    
                    if self.bitrate == 0 {
                        self.bitrate = Int(kbps)
                    }
                    
                    ////
                    
                    dispatch.async.main({ () -> Void in
                        completition(Int(kbps))
                    })
                    
                    ////
                    
                }
                
            } catch (let e) {
                print(e)
                dispatch.async.main({ () -> Void in
                    completition(Int(0))
                })
            }
            
        }
        
        
        
    }
    
    //////////////////////////////////////////////////////////
    
    func getDurationString() -> String {
        
        let min = Int(floor(Double(self.duration) / 60))
        let sec = Int(floor(Double(self.duration) % 60))
        
        if (sec < 10) {
            return "\(min):0\(sec)"
        } else {
            return "\(min):\(sec)"
        }
        
    }
    
    
    /////
    
    
    func fmdbdict() -> Dictionary<String,String> {
        
        /*
         
         "audio_id INTEGER PRIMARY KEY, " +
         "artist TEXT, " +
         "title TEXT, " +
         "lyrics_id INTEGER, " +
         "url TEXT, " +
         "owner_id INTEGER, " +
         "duration INTEGER, " +
         "genre_id INTEGER, " +
         
         "local_url TEXT, " +
         "bitrate INTEGER " +
         
         */
        
        var audioDict = Dictionary<String,String>()
        
        audioDict["audio_id"] = String(self.audioID).sqlString()
        audioDict["artist"] = self.artist.sqlString()
        audioDict["lyrics_id"] = String(self.lyrics_id).sqlString()
        audioDict["url"] = self.audioNetworkURL.sqlString()
        audioDict["owner_id"] = String(self.ownerID).sqlString()
        audioDict["duration"] = String(self.duration).sqlString()
        audioDict["genre_id"] = String(self.genre_id).sqlString()
        
        audioDict["local_url"] = self.audioLocalURL.sqlString()
        audioDict["bitrate"] = String(self.bitrate).sqlString()
        
        return audioDict
        
    }
    
    
    
    

}
