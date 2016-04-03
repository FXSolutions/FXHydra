//
//  FXPlayerService.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation
import StreamingKit
import AVFoundation
import VK_ios_sdk
import SwiftFilePath
import MediaPlayer

class FXPlayerService : NSObject, STKAudioPlayerDelegate {

    //
    // Shared instance
    //
    
    
    var audioPlayer:STKAudioPlayer!
    
    private static let shared = FXPlayerService()
    
    static func sharedManager() -> FXPlayerService {
        return shared
    }
    
    // vars
    
    var currentAudioPlayed:FXAudioItemModel?
    
    var currentAudiosArray = [FXAudioItemModel]()
    var currentAudioIndexInArray = 0
    
    override init() {
        super.init()
        
        var playerOptions = STKAudioPlayerOptions()
        playerOptions.enableVolumeMixer = true
        
        self.audioPlayer = STKAudioPlayer(options: playerOptions)
        self.audioPlayer.equalizerEnabled = true
        
        audioPlayer.delegate = self
        
    }
    
    func playPrevAudio() {
        
        if currentAudioIndexInArray == 0 {
            currentAudioIndexInArray == self.currentAudiosArray.count-1
        } else {
            currentAudioIndexInArray -= 1
        }
        
        self.startPlayAtIndex()
        
    }
    
    func playNextAudio() {
        
        if currentAudioIndexInArray == self.currentAudiosArray.count-1 {
            currentAudioIndexInArray = 0
        } else {
            currentAudioIndexInArray += 1
        }
        
        self.startPlayAtIndex()
        
    }
    
    
    func startPlayAtIndex() {
        
        let audioModel = self.currentAudiosArray[currentAudioIndexInArray]
        
        self.currentAudioPlayed = audioModel
        
        FXSignalsService.sharedManager().changeCurrentItem.fire(audioModel)
        
        self.updateSongInfo(nil)
        
        if audioModel.audioLocalURL == nil {
            self.startPlayNetworkURL(audioModel)
        } else {
            self.startPlayLocalURL(audioModel)
        }
        
        // check settings player
        
        log.debug("::: equalizerBandFrequencies -> \(self.audioPlayer.options.equalizerBandFrequencies) :::")
        
        
    }
    
    func startPlayAudio(model:FXAudioItemModel) {
        
        if model.audioLocalURL == nil {
            self.startPlayNetworkURL(model)
        } else {
            self.startPlayLocalURL(model)
        }
        
    }
    
    
    func updateSongInfo(coverImage:UIImage?) {
        
        var songInfo = Dictionary<String,AnyObject>()
        if (coverImage == nil) {
            let defaultImageCover = UIImage(named: "player_background_default")
            let albumArt = MPMediaItemArtwork(image: defaultImageCover!)
            
            songInfo[MPMediaItemPropertyArtwork] = albumArt
        
        } else {
            let albumArt = MPMediaItemArtwork(image: coverImage!)
            
            songInfo[MPMediaItemPropertyArtwork] = albumArt
        }
        
        songInfo[MPMediaItemPropertyArtist] = self.currentAudioPlayed?.artist
        songInfo[MPMediaItemPropertyTitle] = self.currentAudioPlayed?.title
        songInfo[MPNowPlayingInfoPropertyPlaybackQueueIndex] = self.currentAudioIndexInArray+1
        songInfo[MPNowPlayingInfoPropertyPlaybackQueueCount] = self.currentAudiosArray.count
        
        MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo
        
    }
    
    
    private func startPlayNetworkURL(model:FXAudioItemModel) {
        
        log.info("::: startPlayNetworkURL :::")
        
        self.checkURLForAudio(model) { (audioURL) -> () in
            
            self.currentAudioPlayed = model
            
            let dataSourceFromURL = STKAudioPlayer.dataSourceFromURL(NSURL(string: audioURL)!)
            
            self.audioPlayer.playDataSource(dataSourceFromURL)
            
            self.checkAudioSession()
            
            ////
            
            
            self.getCoverImageFromURL(NSURL(string: audioURL)!)
            
        }
        
    }
    
    private func startPlayLocalURL(model:FXAudioItemModel) {
        
        log.info("::: startPlayNetworkURL :::")
    
        let url = NSURL(fileURLWithPath: Path.documentsDir["FXHydra"][model.audioLocalURL].toString())
    
        let dataSourceFromURL = STKAudioPlayer.dataSourceFromURL(url)
        
        self.audioPlayer.playDataSource(dataSourceFromURL)
        
        self.currentAudioPlayed = model
        self.checkAudioSession()
    }
    
    func checkAudioSession() {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            try audioSession.setActive(true)
            
            UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
            
        } catch {
            log.error("audio session register error")
        }
        
    }
    
    func checkURLForAudio(model:FXAudioItemModel,completition:(String) -> ()) {
        
        dispatch.async.global { () -> Void in
            model.getBitrate { (bitrate) -> () in
                if (bitrate > 0) {
                    
                    dispatch.async.main({ () -> Void in
                        completition(model.audioNetworkURL)
                    })
                    
                } else {
                    
                    FXApiManager.sharedManager().vk_getAudioIDInfo(model.audioID, competition: { (audioModel) -> () in
                        
                        dispatch.async.main({ () -> Void in
                            completition(audioModel.audioNetworkURL)
                        })
                        
                    })
                    
                }
            }
        }
        
    }
    
    
    // stk delegate
    
    /// Raised when an item has started playing
    func audioPlayer(audioPlayer: STKAudioPlayer, didStartPlayingQueueItemId queueItemId: NSObject) {
        //
        log.info("didStartPlayingQueueItemId ::: \(queueItemId)")
        
    }
    
    /// Raised when an item has finished buffering (may or may not be the currently playing item)
    /// This event may be raised multiple times for the same item if seek is invoked on the player
    func audioPlayer(audioPlayer: STKAudioPlayer, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
        log.debug("didFinishBufferingSourceWithQueueItemId ::: \(queueItemId)")
    }
    
    /// Raised when an item has finished playing
    func audioPlayer(audioPlayer: STKAudioPlayer, didFinishPlayingQueueItemId queueItemId: NSObject, withReason stopReason: STKAudioPlayerStopReason, andProgress progress: Double, andDuration duration: Double) {
        log.debug("didFinishPlayingQueueItemId ::: \(queueItemId)")
    }
    
    /// Raised when the state of the player has changed
    func audioPlayer(audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
        log.debug("audioPlayer stateChanged ::: state : \(state) , prevState : \(previousState)")
        
        if state == STKAudioPlayerState.Paused {
            
            log.debug("::: paused :::")
            FXSignalsService.sharedManager().playedStateChangedOnPlaying.fire(false)
            
        } else if (state == STKAudioPlayerState.Stopped) {
            
            log.debug("::: stopped :::")
            FXSignalsService.sharedManager().playedStateChangedOnPlaying.fire(false)
            
            if(previousState == STKAudioPlayerState.Buffering) {
                self.playNextAudio()
            }
            
        } else if (state == STKAudioPlayerState.Playing) {
            
            log.debug("::: playing :::")
            FXSignalsService.sharedManager().playedStateChangedOnPlaying.fire(true)
            
        } else if (state == STKAudioPlayerState.Buffering) {
            
            log.debug("::: Buffering :::")
            
        } else if (state == STKAudioPlayerState.Disposed) {
            
            log.debug("::: Disposed :::")
            
        }
        
    }
    
    /// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
    func audioPlayer(audioPlayer: STKAudioPlayer, unexpectedError errorCode: STKAudioPlayerErrorCode) {
        log.error("audioPlayer error ::: \(errorCode)")
    }
    
    /// Optionally implemented to get logging information from the STKAudioPlayer (used internally for debugging)
    func audioPlayer(audioPlayer: STKAudioPlayer, logInfo line: String) {
        //log.debug("audioPlayer info ::: \(line)")
    }
    
    /// Raised when items queued items are cleared (usually because of a call to play, setDataSource or stop)
    func audioPlayer(audioPlayer: STKAudioPlayer, didCancelQueuedItems queuedItems: [AnyObject]) {
        log.debug("didCancelQueuedItems info ::: \(queuedItems)")
    }
    
    func getCoverImageFromURL(audio_url:NSURL) {
        
        let defaultImageCover = UIImage(named: "player_background_default")
        FXSignalsService.sharedManager().updateCoverImage.fire(defaultImageCover)
        
        ////
        
        let asset:AVAsset? = AVAsset(URL: audio_url)
        
        if (asset != nil) {
            
            asset!.loadValuesAsynchronouslyForKeys(["commonMetadata"], completionHandler: {

                let artworks = AVMetadataItem.metadataItemsFromArray((asset?.commonMetadata)!, withKey: AVMetadataCommonKeyArtwork, keySpace: AVMetadataKeySpaceCommon)
                
                for item in artworks {
                    
                    if item.keySpace == AVMetadataKeySpaceID3 {
                        
                        log.debug("::: AVMetadataKeySpaceID3 cover image founded!!:::")
                        
                        let imageData = item.value as! NSData
                        let image = UIImage(data: imageData)
                        
                        FXSignalsService.sharedManager().updateCoverImage.fire(image)
                        
                        self.updateSongInfo(image)
                        
                    } else if (item.keySpace == AVMetadataKeySpaceiTunes) {
                        
                        log.debug("::: AVMetadataKeySpaceiTunes cover image founded!! \(item.value) :::")
                        
//                        let image = UIImage(data: (item.value?.copyWithZone(nil))! as! NSData)
//                        
//                        FXSignalsService.sharedManager().updateCoverImage.fire(image)
                        
                    }
                    
                }
                
                
                
            })
            
        }
    
        
    }
    
    /*
        0.0, 0.0, 0.0, 0.0,
        0.0, 0.0, 0.0, 0.0, 
        0.0, 0.0, 0.0, 0.0, 
        0.0, 0.0, 0.0, 0.0, 
        0.0, 0.0, 0.0, 0.0, 
        0.0, 0.0, 0.0, 0.0
    */
    
    
}
