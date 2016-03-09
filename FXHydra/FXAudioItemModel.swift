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

}
