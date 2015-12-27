//
//  HRDatabaseManager.swift
//  Hydra
//
//  Created by Evgeny Abramov on 7/4/15.
//  Copyright (c) 2015 Evgeny Abramov. All rights reserved.
//

import Foundation

class HRDatabaseManager {
    
    static let sharedInstance = HRDatabaseManager()

    
    let databaseName = "hydradb.sqlite"
    var database: FMDatabase?
    var queue: dispatch_queue_t?
    
    
//    required override init() {
//        super.init()
//        self.databaseSetup()
//    }
    
    init() {
        self.databaseSetup()
    }
    
    func databaseSetup () {
        
        log.debug("Database setup starting")
        if let docDir: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first {
            let path = docDir.stringByAppendingPathComponent(databaseName)
            self.database = FMDatabase(path: path)
            self.queue = dispatch_queue_create("Database queue", DISPATCH_QUEUE_SERIAL)
        }
        
        self.database!.open()
        log.debug("Database opened : SUCCESS")
        self.createTables()
        
    }
    
    func deleteDB() {
        
        if let docDir: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first {
            
            let path = docDir.stringByAppendingPathComponent(databaseName)
            
            if NSFileManager.defaultManager().fileExistsAtPath(path) {
                
                do {
                    try! NSFileManager.defaultManager().removeItemAtPath(path)
                }
                
                log.debug("Database deleted : SUCCESS")
            } else {
                log.debug("Database deleted : Not exists")
            }
            
        }
    }
    
    deinit {
        self.database!.close()
    }
    
    /////
    
    func createTables () {
        
        // chats table
        /*
        
        avatar  * text // dict as text
        canspek * integer
        chat_id * integer primary key
        chat_description * text
        email * integer
        group * integer // grouptype
        last_action * integer
        last_updated * integer
        owner * integer
        participants * text
        particiapnts_count * integer
        private * integer
        rights * text // dict as text
        roomname * text
        time_created * integer
        topic * text
        last_message * integer
        unreadtotoal * integer
        
        
        self.title = json["title"].stringValue
        self.audioID = json["id"].intValue
        self.lyrics_id = json["lyrics_id"].intValue
        self.ownerID = json["owner_id"].intValue
        self.artist = json["artist"].stringValue
        self.duration = json["duration"].intValue
        self.genre_id = json["genre_id"].intValue
        self.audioNetworkURL = json["url"].stringValue
        
        */
        
        let downloadsSQL = "create table IF NOT EXISTS Downloads (audio_id integer primary key, title text, lyrics_id integer, owner_id integer, artist text, duration integer, genre_id integer, local_url string);"
        
        //avatar text, chat_description text, email integer, grouptype integer, last_action integer, last_updated integer, owner integer, participants text, participants_count integer, private integer, rights text, roomname text, time_created integer, topic text, last_message integer,unreadtotoal integer,type0uid integer,type0user_status integer, last_message_body text
        
        if self.database!.executeUpdate(downloadsSQL, withArgumentsInArray: nil) {
            log.debug("'Downloads' table created")
        } else {
            log.error("'Downloads' table created error")
        }
        
        
        let downloadsIndexSQL = "CREATE INDEX IF NOT EXISTS audioid_index ON Downloads (audio_id);"
        
        if self.database!.executeUpdate(downloadsIndexSQL, withArgumentsInArray: nil) {
            log.debug("'downloadsIndexSQL' index created")
        } else {
            log.error("'downloadsIndexSQL' index created error")
        }
        
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        
        log.debug("Database Tables created")
    }
    
    //////////////////////////////
    // save audio model in sql  //
    //////////////////////////////
    
    func saveInDB(model:HRAudioItemModel) {
        dispatch_async(self.queue!, { () -> Void in
            let sql = "insert or replace into Downloads (audio_id, title, lyrics_id, owner_id, artist, duration, genre_id, local_url) values \(model.sqlValue());"
            
            self.database!.executeUpdate(sql, withArgumentsInArray: nil)
        })
    }
    
    ////
    
    func getAllDownloads(completion: ([HRAudioItemModel]) -> ()) {

        dispatch_async(self.queue!, { () -> Void in
            var array: [HRAudioItemModel] = []
            
            let sql = "select * from Downloads"
            if let set: FMResultSet = self.database!.executeQuery(sql, withArgumentsInArray: nil) {
                while set.next() {
                    array.append(HRAudioItemModel(set: set))
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(array)
            })
        })
    }

    func getAllDownloadsIds(completion: ([Int]) -> ()) {
        dispatch_async(self.queue!, { () -> Void in
            var array: [Int] = []
            
            let sql = "select audio_id from Downloads"
            if let set: FMResultSet = self.database!.executeQuery(sql, withArgumentsInArray: nil) {
                while set.next() {
                    array.append(set.longForColumn("audio_id"))
                }
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(array)
            })
        })
    }
    
    func clearAllTables() {
        
        let deleteAllFromSessions = "DELETE FROM Downloaded"
        
        if self.database!.executeUpdate(deleteAllFromSessions, withArgumentsInArray: nil) {
            log.debug("Sessions table clear")
        }
        
    }

    
}
