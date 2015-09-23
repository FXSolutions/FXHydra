import Foundation

class HRAPIManager {
    
    //////////////////////////////////////////
    static let sharedInstance = HRAPIManager()
    //////////////////////////////////////////
    
    
    // audio.get
    func vk_audioget(count:Int,offset:Int,completion: ([HRAudioItemModel]) -> ()) {
        
        let getAudio = VKRequest(method: "audio.get", andParameters: ["count":count,"offset":offset], andHttpMethod: "GET")
        
        getAudio.executeWithResultBlock({ (response) -> Void in
            
                var audiosArray = Array<HRAudioItemModel>()
                
                let json = response.json as! Dictionary<String,AnyObject>
                let items = json["items"] as! Array<Dictionary<String,AnyObject>>
                
                
                for audioDict in items {
                    
                    
                    let jsonAudioItem = JSON(audioDict)
                    let audioItemModel:HRAudioItemModel = HRAudioItemModel(json: jsonAudioItem)
                    
                    if HRDataManager.sharedInstance.arrayWithDownloadedIds.contains(audioItemModel.audioID) {
                        audioItemModel.downloadState = 3
                    } else {
                        audioItemModel.downloadState = 1
                    }
                    
                    audiosArray.append(audioItemModel)
                    
                }
            
                completion(audiosArray)
                
            
            }, errorBlock: { (error) -> Void in
                
                log.error("audio.get #### \(error)")
                
        })
        
        
    }
    
    

}
