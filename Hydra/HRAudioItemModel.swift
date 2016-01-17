import Foundation

enum HRDownloadState: Int {
    case NotDownloaded = 1, InProgress = 2, Complete = 3
}

enum HRGlobalState: Int {
    case Global = 1, Playlist = 2
}


class HRAudioItemModel {
    
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
    
    init(set: FMResultSet) {
        
        
        self.audioID        = set.longForColumn("audio_id")
        self.title          = set.stringForColumn("title")
        self.lyrics_id      = set.longForColumn("lyrics_id")
        self.ownerID        = set.longForColumn("owner_id")
        self.artist         = set.stringForColumn("artist")
        self.duration       = set.longForColumn("duration")
        self.genre_id       = set.longForColumn("genre_id")
        self.audioLocalURL  = set.stringForColumn("local_url")
        self.downloadedTime = set.longForColumn("downloaded_time")
        
    }
    
    func sqlValue() -> String {
        
        //audio_id integer primary key, title text, lyrics_id integer, owner_id integer, artist text, duration integer, genre_id integer, local_url string
        
        let sqlAudioModel = "('\(audioID!)' , '\(title!)' , '\(lyrics_id)' , '\(ownerID!)' , '\(artist!)','\(duration!)','\(genre_id!)','\(audioLocalURL!)','\(downloadedTime!)')"
    
        return sqlAudioModel
    }
    
    
}
