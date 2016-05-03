//
//  FXDatabaseService.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation

class FXDatabaseService {
    
    //
    // Shared instance
    //
    
    private static let shared = FXDatabaseService()
    
    static func sharedManager() -> FXDatabaseService {
        return shared
    }
    
    ////////////////////////////////////////////////////////////
    
    let databaseName = "fxhydradb.sqlite"
    var database: FMDatabase!
    
    var queueDb: dispatch_queue_t!
    
    
    init() {
        self.getAllSqliteInfo()
        self.setupDatabase()
    }
    
    func getAllSqliteInfo() {
        
        log.info("Init ::: TMDatabaseManager")
        
    }
    
    func setupDatabase() {
        
        log.debug("Database setup starting")
        
        if let docDir: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first {
            let path = docDir.stringByAppendingPathComponent(databaseName)
            self.database = FMDatabase(path: path)
            self.queueDb = dispatch_queue_create("Database queue", DISPATCH_QUEUE_SERIAL)
        }
        
        self.database!.open()
        log.debug("Database opened : SUCCESS")
        
        self.checkVersion()
        self.createTablesAndIndexes()
        
    }
    
    func checkVersion() {
        
        let sql = "select sqlite_version();"
        
        let versionString = self.database.stringForQuery(sql)
        log.debug("sqlite version === \( versionString )")
        
    }
    
    func createTablesAndIndexes() {
        
        self.createDownloadsTable()
        
    }
    
    deinit {
        self.database!.close()
    }
    
    ////////////////////////////////////////
    
    func createAudiosTable() {
        
    }
    
    func createDownloadsTable() {
        
        // create downloads table
        
        let downloadsSQL = "CREATE TABLE IF NOT EXISTS DOWNLOADS (" +
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
        ")"
        
        ///
        
        if self.database!.executeUpdate(downloadsSQL, withArgumentsInArray: nil) {
            log.debug("'DOWNLOADS' table created")
        } else {
            log.error("'DOWNLOADS' table created error")
        }
        
        //////////////////////////////////////////////////////////////////
        
    }
    
    func createPlaylistsTable() {
        
    }
    
    func saveDownloadModel(audio_model:FXAudioItemModel,cb:(Bool) -> ()) {
        
        dispatch_async(self.queueDb!) {
        
            let audioDict = audio_model.fmdbdict()
            
            
            let audio_id    = NSString(string:audioDict["audio_id"]!)
            let artist      = NSString(string:audioDict["artist"]!)
            let title       = NSString(string:audioDict["title"]!)
            let lyrics_id   = NSString(string:audioDict["lyrics_id"]!)
            let url         = NSString(string:audioDict["url"]!)
            let owner_id    = NSString(string:audioDict["owner_id"]!)
            let duration    = NSString(string:audioDict["duration"]!)
            let genre_id    = NSString(string:audioDict["genre_id"]!)
            let local_url   = NSString(string:audioDict["local_url"]!)
            let bitrate     = NSString(string:audioDict["bitrate"]!)
            
            
            var sql = "INSERT OR REPLACE INTO DOWNLOADS (audio_id, artist, title, lyrics_id, url, owner_id, duration, genre_id, local_url, bitrate) values"
            
            sql += "('\(audio_id)' , '\(artist)' , '\(title)' , '\(lyrics_id)' , '\(url)' , '\(owner_id)' , '\(duration)' , '\(genre_id)' , '\(local_url)' , '\(bitrate)')"
            
            let res = self.database.executeUpdate(sql, withArgumentsInArray: nil)
            
            cb(res)
            
        }
        
    }
    
    func getAllDownloadsFromDB(cb:([FXAudioItemModel]) ->()) {
        
        dispatch_async(self.queueDb!) {
            
            let sql = "SELECT * FROM DOWNLOADS"
            
            var downloadsArray = [FXAudioItemModel]()
            
            if let set:FMResultSet = self.database.executeQuery(sql, withArgumentsInArray: nil) {
                while set.next() {
                    
                    let downloadModel = FXAudioItemModel(set: set)
                    downloadsArray.append(downloadModel)
                    
                }
            }
            
            dispatch.async.main({
                cb(downloadsArray)
            })
            
        }
        
    }
    
    
    
    

}
