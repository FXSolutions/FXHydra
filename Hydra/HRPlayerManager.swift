//
//  HRPlayerManager.swift
//  Hydra
//
//  Created by Evgeny Abramov on 7/4/15.
//  Copyright (c) 2015 Evgeny Abramov. All rights reserved.
//

import UIKit
import AVFoundation
import Haneke
import VK_ios_sdk

class HRCurrentSongPlayedTime {
    var duration : Int!
    var timePlayed : Int!
}

class HRPlayerManager {
    
    static let sharedInstance = HRPlayerManager()
    
    var playback : AFSoundPlayback!
    var queue : AFSoundQueue!

    var items = Array<HRAudioItemModel>()
    var saveItems = Array<HRAudioItemModel>()
    var currentPlayIndex = 0
    
    // signals
    let currentSongChange = Signal<(HRAudioItemModel!)>()
    let currentSongTimePlayed = Signal<(Int!,Int!)>()
    var currentItem : HRAudioItemModel!
    
    var broadcastState = false
    var repeatState = false
    var shuffleState = false
    
    var playState = false
    var playSignal = Signal<(Bool!)>()
    var coverImage = UIImage(named: "placeholder")
    var coverChanged = Signal<(UIImage!)>()
    var backgroundImage = UIImage(named: "placeholderBackground")
    var backgroundChanged = Signal<(UIImage!)>()
    var lyricsText = "Загрузка..";
    var lyricsLoaded = Signal<(String!)>()
    
    func playItem(song: HRAudioItemModel) {
        
        self.currentItem = song
        
        var songitem : AFSoundItem!
        
        if (song.audioLocalURL != nil) {
            
            //let songURL = NSURL(string: song.audioLocalURL!)
            var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let docsDir: AnyObject = dirPaths[0]
            let soundFilePath = docsDir.stringByAppendingPathComponent(song.audioLocalURL!)
            
            songitem = AFSoundItem(localResource: "", atPath: soundFilePath)
            
        } else {
            
            let songURL = NSURL(string: song.audioNetworkURL!)
            songitem = AFSoundItem(streamingURL: songURL!)
        }
        
        songitem.duration = song.duration
        
        if (self.queue != nil) {
            self.queue.pause()
            self.queue.addItem(songitem)
            self.queue.playItem(songitem)
        } else {
            self.queue = AFSoundQueue(items: [songitem])
            self.queue.playItem(songitem)
        }
        
        self.currentSongChange.fire(song)
        self.currentSongTimePlayed.fire((song.duration,0))
        self.broadcast(song)
        self.getItunesCover(song.artist, titleIn: song.title)

        queue.listenFeedbackUpdatesWithBlock({ (songitem) -> Void in
            //log.debug("Item duration: \(song.duration) - time elapsed: \(songitem.timePlayed)")
            
            // create
            let playedTime = HRCurrentSongPlayedTime()
            
            // set
            playedTime.duration = song.duration
            playedTime.timePlayed = songitem.timePlayed
            
            // fire
            self.currentSongTimePlayed.fire((song.duration,songitem.timePlayed))
            
            if song.duration == songitem.timePlayed+1 {
                if self.repeatState == false {
                    self.playNext()
                } else {
                    self.playRepeat(song)
                }
            }
            
        }, andFinishedBlock: { (nextitem) -> Void in
            
        })
        
    }
    
    func playRepeat(song:HRAudioItemModel) {
        self.playItem(song)
    }
    
    func playCurrent() {
        self.playSignal.fire(true)
        HRPlayerManager.sharedInstance.queue.playCurrentItem()
    }
    
    func pause() {
        self.playSignal.fire(false)
        HRPlayerManager.sharedInstance.queue.pause()
    }
    
    func playNext() {
        
        if self.items.count > 0 {
            if self.items.count != self.currentPlayIndex + 1 {
                let song = self.items[self.currentPlayIndex+1]
                self.currentPlayIndex = self.currentPlayIndex + 1
                self.playItem(song)
            } else {
                self.currentPlayIndex = 0
                let song = self.items[0]
                self.playItem(song)
            }
        }
        
    }
    
    func playPrev() {
        
        if self.items.count > 0 {
            if self.currentPlayIndex - 1 == -1 {
                self.currentPlayIndex = self.items.count - 1
                let song = self.items[self.items.count-1]
                self.playItem(song)
            } else if self.currentPlayIndex-1 > -1 {
                let song = self.items[self.currentPlayIndex-1]
                self.currentPlayIndex = self.currentPlayIndex - 1
                self.playItem(song)
            }
        }
        
    }
    
    func broadcast(audio:HRAudioItemModel) {
        let audioBoadcastFormat : String!
        
        if self.broadcastState == true {
            audioBoadcastFormat = "\(audio.ownerID)_\(audio.audioID)"
        } else {
            audioBoadcastFormat = ""
        }
        
        let broadcast = VKRequest(method: "audio.setBroadcast", andParameters: ["audio":audioBoadcastFormat])
        
        broadcast.executeWithResultBlock({ (response) -> Void in
            
            }, errorBlock: { (error) -> Void in
                // error
                print(error)
        })
        
        
    }
    
    func addAudio(audio:HRAudioItemModel) {
        let audioAdd = VKRequest(method: "audio.add", andParameters: ["audio_id":audio.audioID,"owner_id":audio.ownerID])
        
        audioAdd.executeWithResultBlock({ (response) -> Void in
            log.debug("\(response.json)")
            }, errorBlock: { (error) -> Void in
                // error
                print(error)
        })
    }
    
    // settings
    
    func actionBroadcast() {
        if self.broadcastState == true {
            self.broadcastState = false
            if (self.currentItem != nil) {
                self.broadcast(self.currentItem)
            }
            
        } else {
            self.broadcastState = true
            if (self.currentItem != nil) {
                self.broadcast(self.currentItem)
            }
        }
        
        
    }
    
    func actionRepeat() {
        
        if self.repeatState == false {
            self.repeatState = true
        } else {
            self.repeatState = false
        }
        
    }
    
    func actionAddCurrentSong() {
        if (self.currentItem != nil) {
            self.addAudio(self.currentItem)
        }
    }
    
    func getItunesCover(artistIn:String!, titleIn:String!) {
        
        ItunesSearch.sharedInstance().getTrackWithName(titleIn, artist: artistIn, album: nil, limitOrNil: 1, successHandler: { (result) -> Void in
            var resultArray:Array<Dictionary<String,AnyObject>> = result as! Array<Dictionary<String,AnyObject>>
            if resultArray.count > 0 {
                let song = resultArray[0]
                let artworkURL:String = song["artworkUrl100"] as! String
                let bigArtworkURL = artworkURL.stringByReplacingOccurrencesOfString("100x100bb", withString: "600x600bb")
                
                log.debug("ARTWORK!! = \(bigArtworkURL)")
                
                let imageURL = NSURL(string: bigArtworkURL)
                
                dispatch.async.main({ () -> Void in
                
                    let cache = Shared.imageCache
                    let fetcher = NetworkFetcher<UIImage>(URL:imageURL!)
                    cache.fetch(fetcher: fetcher).onSuccess { image in
                        
                        dispatch.async.main({ () -> Void in
                            self.coverImage = image
                            self.coverChanged.fire(image)
                            self.backgroundImage = image
                            self.backgroundChanged.fire(image)
                            self.setSongInfoWithImage(image,artistInB: artistIn, titleInB: titleIn)
                            
                        })
                        
                    }
                })
                
            } else {
                dispatch.async.main({ () -> Void in
                    self.coverImage = UIImage(named: "placeholder")
                    self.coverChanged.fire(UIImage(named: "placeholder"))
                    self.backgroundImage = UIImage(named: "placeholderBackground")
                    self.backgroundChanged.fire(UIImage(named: "placeholderBackground"))
                    self.setSongInfoWithImage((UIImage(named: "placeholder")!), artistInB: artistIn, titleInB: titleIn)
                })
            }
            
            
            }) { (error) -> Void in
                //
        }
    }
    
    
    func setSongInfoWithImage(image : UIImage,artistInB:String,titleInB:String) {
        
        var songInfo = Dictionary<String,AnyObject>()
        songInfo[MPMediaItemPropertyTitle] = titleInB
        songInfo[MPMediaItemPropertyArtist] = artistInB
        
        // artwork image
        let artwork = MPMediaItemArtwork(image: image)
        songInfo[MPMediaItemPropertyArtwork] = artwork
        
        MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo
        
    }
    
    func actionShuffle() {
        
        if self.shuffleState == false {
            self.saveItems = self.items
            self.items = self.items.shuffle()
            self.shuffleState = true
            
        } else {
            self.shuffleState = false
            self.items = self.saveItems
        }
        
    }
    
    func lyricsAction(audio:HRAudioItemModel) {
        
        let getAudioLyrics = VKRequest(method: "audio.getLyrics", andParameters: ["lyrics_id":audio.lyrics_id])
        
        getAudioLyrics.executeWithResultBlock({ (response) -> Void in
            let json = response.json as! Dictionary<String,AnyObject>
            let text = json["text"] as! String
            self.lyricsLoaded.fire(text)
            
            log.debug("\(response.json)")
            }, errorBlock: { (error) -> Void in
                // error
                print(error)
        })
        
    }
    
    func actionShowSongLyrics() {
        if self.currentItem != nil && self.currentItem.lyrics_id != 0 {
            self.lyricsAction(self.currentItem)
        } else {
            self.lyricsLoaded.fire("Нет текста для данного трека")
        }
    }

    

}
