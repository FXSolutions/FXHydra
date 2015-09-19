//
//  HRAudioItemModel.swift
//  Hydra
//
//  Created by Evgeny Abramov on 7/4/15.
//  Copyright (c) 2015 Evgeny Abramov. All rights reserved.
//

import Foundation

enum HRDownloadState: Int {
    case NotDownloaded = 1, Proccess = 2, Complite = 3
}

enum HRGlobalState: Int {
    case Global = 1, Playlist = 2
}


class HRAudioItemModel: NSObject {
    
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
    
    
    init(json : JSON) {
        /*
        [title: Black (Contrvbvnd Edit), id: 378647957, lyrics_id: 261830649, owner_id: 2360042, artist: MAKJ & Thomas Newson, duration: 223, genre_id: 18, url: https://cs1-36v4.vk-cdn.net/p13/07cbb203d71f1a.mp3?extra=wnsZiEr0T7HPx8CtfOHVLhnvNK2iNo1nuJo_uusniukWtC8Z8B6_38sULq-yQeakAyDlznrvx-52Y8QxLk0GWk3Yj4g89g]
        */
        
        self.title = json["title"].stringValue
        self.audioID = json["id"].intValue
        self.lyrics_id = json["lyrics_id"].intValue
        self.ownerID = json["owner_id"].intValue
        self.artist = json["artist"].stringValue
        self.duration = json["duration"].intValue
        self.genre_id = json["genre_id"].intValue
        self.audioNetworkURL = json["url"].stringValue
    
    }
    
    init(set: FMResultSet) {
        
        
        self.audioID        = set.longForColumn("audio_id")
        self.title          = set.stringForColumn("title")
        self.lyrics_id      = set.longForColumn("lyrics_id")
        self.ownerID        = set.longForColumn("owner_id")
        self.artist         = set.stringForColumn("artist")
        self.duration       = set.longForColumn("duration")
        self.genre_id       = set.longForColumn("genre_id")
        self.audioLocalURL  = set.stringForColumn("local_url")
        
    }
    
    func sqlValue() -> String {
        
        //audio_id integer primary key, title text, lyrics_id integer, owner_id integer, artist text, duration integer, genre_id integer, local_url string
        
        let sqlAudioModel = "('\(audioID!)' , '\(title!)' , '\(lyrics_id)' , '\(ownerID!)' , '\(artist!)','\(duration!)','\(genre_id!)','\(audioLocalURL!)')"
    
        return sqlAudioModel
    }
    
    
}
