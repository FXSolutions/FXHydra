//
//  FXApiManager.swift
//  FXHydra
//
//  Created by kioshimafx on 3/16/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation
import VK_ios_sdk

class FXApiManager {

    //
    // Shared instance
    //
    
    private static let shared = FXApiManager()
    
    static func sharedManager() -> FXApiManager {
        return shared
    }
    
    
    func vk_getAudiosWithOffset(offset:Int,count:Int,competition:([FXAudioItemModel]) -> () ) {
        
        let getAudio : VKRequest!
        
        getAudio = VKRequest(method: "audio.get", parameters: ["count":count,"offset":offset])
        
        dispatch.async.global({ () -> Void in
            getAudio.executeWithResultBlock({ (response) -> Void in
                
                
                var audiosArray = Array<FXAudioItemModel>()
                
                let json = response.json as! Dictionary<String,AnyObject>
                let items = json["items"] as! Array<Dictionary<String,AnyObject>>
                
                for audioDict in items {
                    
                    let jsonAudioItem = JSON(audioDict)
                    let audioItemModel:FXAudioItemModel = FXAudioItemModel(json: jsonAudioItem)
                    
                    audioItemModel.downloadState = 1
                    
                    audiosArray.append(audioItemModel)
                    
                }
                
                dispatch.async.main({ () -> Void in
                    competition(audiosArray)
                })
                
                }, errorBlock: { (error) -> Void in
                    
                    log.error("audio.get #### \(error.description)")
                    
            })
        })
        
    }
    
    func vk_getAudioIDInfo(audioID:Int,competition:(FXAudioItemModel) -> () ) {
        
        let getAudio : VKRequest!
        
        getAudio = VKRequest(method: "audio.get", parameters: ["audio_ids":[audioID]])
        
        dispatch.async.global({ () -> Void in
            getAudio.executeWithResultBlock({ (response) -> Void in
                
                let json = response.json as! Dictionary<String,AnyObject>
                let items = json["items"] as! Array<Dictionary<String,AnyObject>>
                
                if let audioInfo = items.first {
                    
                    let jsonAudioItem = JSON(audioInfo)
                    let audioItemModel:FXAudioItemModel = FXAudioItemModel(json: jsonAudioItem)
                    
                    audioItemModel.downloadState = 1
                    
                    dispatch.async.main({ () -> Void in
                        competition(audioItemModel)
                    })
                    
                }
                
                }, errorBlock: { (error) -> Void in
                    
                    log.error("audio.get #### \(error.description)")
                    
            })
        })
        
    }
    
    func vk_audiosearch(query:String,offset:Int,count:Int,competition:([FXAudioItemModel]) -> ()) {
        
        let audioSearch = VKRequest(method: "audio.search", parameters: ["q":query,"auto_complete":1,"sort":2,"offset":offset,"count":count])
        log.debug("\(audioSearch.methodParameters)")
        
        dispatch.async.global {
            
            audioSearch.executeWithResultBlock({ (vk_response) in
                
                    let json = vk_response.json as! Dictionary<String,AnyObject>
                    let items = json["items"] as! Array<Dictionary<String,AnyObject>>
                    
                    var audiosArray = [FXAudioItemModel]()
                    
                    for audioDict in items {
                        
                        let jsonAudioItem = JSON(audioDict)
                        let audioItemModel = FXAudioItemModel(json: jsonAudioItem)
                        
                        audiosArray.append(audioItemModel)
                        
                    }
                    
                    competition(audiosArray)
                
                }, errorBlock: { (error) in
                    
                    log.error("\(error.description)")
                    
            })
            
        }
        
        
    }
    
    func vk_audioGetRecommendations(target_audio:String,offset:Int,count:Int,competition:([FXAudioItemModel]) -> ()) {
        
        var audioRecommendations:VKRequest!
        
        if target_audio.characters.count > 0 {
            audioRecommendations = VKRequest(method: "audio.getRecommendations", parameters: ["target_audio":target_audio,"offset":offset,"count":count])
        } else {
            audioRecommendations = VKRequest(method: "audio.getRecommendations", parameters: ["offset":offset,"count":count])
        }
        
        dispatch.async.global {
            
            audioRecommendations.executeWithResultBlock({ (vk_response) in
                
                let json = vk_response.json as! Dictionary<String,AnyObject>
                let items = json["items"] as! Array<Dictionary<String,AnyObject>>
                
                var audiosArray = [FXAudioItemModel]()
                
                for audioDict in items {
                    
                    let jsonAudioItem = JSON(audioDict)
                    let audioItemModel = FXAudioItemModel(json: jsonAudioItem)
                    
                    audiosArray.append(audioItemModel)
                    
                }
                
                competition(audiosArray)
                
                }, errorBlock: { (error) in
                    
                    log.error("\(error.description)")
                    
            })
            
        }
        
        
    }
    
    
    
}
