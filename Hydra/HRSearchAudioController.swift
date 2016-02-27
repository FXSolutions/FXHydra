//
//  HRSearchAudioController.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/22/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit
import VK_ios_sdk

class HRSearchAudioController: UITableViewController,UISearchResultsUpdating, UISearchControllerDelegate {

    var background : UIView!
    var audios      = Array<HRAudioItemModel>()
    var footer      = HRFooterProgress()
    var canSearch   = true
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init!(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(HRAudioSearchCell.self, forCellReuseIdentifier: "HRAudioSearchCell")
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = self.footer
        
        self.tableView.backgroundColor = UIColor ( red: 0.2228, green: 0.2228, blue: 0.2228, alpha: 1.0 )
        self.tableView.separatorColor = UIColor ( red: 0.2055, green: 0.2015, blue: 0.2096, alpha: 1.0 )
        
        self.view.backgroundColor = UIColor ( red: 0.1221, green: 0.1215, blue: 0.1227, alpha: 1.0 )
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0)
        self.tableView.indicatorStyle = UIScrollViewIndicatorStyle.White
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.audios.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let audio = self.audios[indexPath.row]
        let cell:HRAudioSearchCell = self.tableView.dequeueReusableCellWithIdentifier("HRAudioSearchCell", forIndexPath: indexPath) as! HRAudioSearchCell
        
        cell.audioAristLabel.text = audio.artist
        cell.audioTitleLabel.text = audio.title
        //cell.allMusicController = self
        cell.audioModel = audio
        cell.audioTimeLabel.text = self.durationFormater(Double(audio.duration))
        
        cell.bitRateBackgroundImage.image = UIImage(named: "bitrate_background")?.imageWithColor2(UIColor ( red: 0.3735, green: 0.3735, blue: 0.3735, alpha: 1.0 ))
//        
//        if audio.downloadState == 3 {
//            
//            cell.downloadedImage.hidden = false
//            cell.downloadedImage.image = UIImage(named: "donebutton")?.imageWithColor2(UIColor.whiteColor())
//            
//            // complete
//            
//        } else {
//            
//            cell.downloadedImage.hidden = true
//            
//        }
        
        if (audio.bitrate == 0) {
            
            dispatch.async.global { () -> Void in
                
                self.getBitrate(audio, completition: { (bitrate) -> () in
                    dispatch.async.main({ () -> Void in
                        cell.audioBitrate.text = "\(bitrate)"
                        
                        if (bitrate > 256) {
                            cell.bitRateBackgroundImage.image = UIImage(named: "bitrate_background")?.imageWithColor2(UIColor ( red: 0.0657, green: 0.5188, blue: 0.7167, alpha: 1.0 ))
                        }
                        
                    })
                })
                
            }
            
        } else {
            
            cell.audioBitrate.text = "\(audio.bitrate)"
            
            if (audio.bitrate > 256) {
                cell.bitRateBackgroundImage.image = UIImage(named: "bitrate_background")?.imageWithColor2(UIColor ( red: 0.0657, green: 0.5188, blue: 0.7167, alpha: 1.0 ))
            }
            
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        dispatch.async.main { () -> Void in
            
            let audioLocalModel = self.audios[indexPath.row]
            
            HRPlayerManager.sharedInstance.items = self.audios
            HRPlayerManager.sharedInstance.currentPlayIndex = indexPath.row
            HRPlayerManager.sharedInstance.playItem(audioLocalModel)
            
            self.presentViewController(PlayerController(), animated: true, completion: nil)
            
        }
        
        
    }
    
    func downloadAudio(model:HRAudioItemModel,progressView:UIProgressView) {
        
        HRDownloadManager.sharedInstance.downloadAudio(model) { (progress) -> () in
            
            dispatch.async.main({ () -> Void in
                log.debug("download progress = \(progress)")
                progressView.hidden = false
                progressView.setProgress(Float(progress), animated: true)
            })
            
        }
        
    }
    
    func setFooter() {
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        if canSearch == true {
            canSearch = false
            if searchController.searchBar.text != "" {
                log.debug("\(searchController.searchBar.text)")
                self.loadSearch(searchController.searchBar.text)
            } else {
                self.audios = Array<HRAudioItemModel>()
                self.tableView.reloadData()
                canSearch = true
            }
        }
    }
    
    func loadSearch(query: String!) {
        
        self.footer.titleText("")
        self.footer.startProgress()
        self.audios = Array<HRAudioItemModel>()
        
        let audioSearch = VKRequest(method: "audio.search", parameters: ["q":query,"auto_complete":1,"sort":2,"offset":self.audios.count,"count":100])
        
        audioSearch.executeWithResultBlock({ (response) -> Void in
            
            let json = response.json as! Dictionary<String,AnyObject>
            let items = json["items"] as! Array<Dictionary<String,AnyObject>>
            
            
            for audioDict in items {
                
                print(audioDict)
                
                let jsonAudioItem = JSON(audioDict)
                let audioItemModel = HRAudioItemModel(json: jsonAudioItem)
                
                self.audios.append(audioItemModel)
                
            }
            
            // set footer info
            self.footer.stopProgress()
            self.footer.titleText("Найдено: \(self.audios.count)")
            
            self.tableView.reloadData()
            self.canSearch = true
            
            }, errorBlock: { (error) -> Void in
                // error
                print(error)
        })
        
    }
    
    func durationFormater(duration:Double) -> String {
        
        let min = Int(floor(duration / 60))
        let sec = Int(floor(duration % 60))
        
        if (sec < 10) {
            return "\(min):0\(sec)"
        } else {
            return "\(min):\(sec)"
        }
        
    }
    
    private func getBitrate(audio:HRAudioItemModel,completition:(Int) -> ()) {
        
        let audioURL = NSURL(string: "\(audio.audioNetworkURL)")!
        
        let request1: NSMutableURLRequest = NSMutableURLRequest(URL: audioURL)
        request1.HTTPMethod = "HEAD"
        
        var response : NSURLResponse?
        
        do {
            
            try NSURLConnection.sendSynchronousRequest(request1, returningResponse: &response)
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                let size = httpResponse.expectedContentLength
                let kbit = size/128;//calculate bytes to kbit
                let kbps = ceil(round(Double(kbit)/Double(audio.duration))/16)*16
                
                print("kbps === \(kbps)")
                
                audio.bitrate = Int(kbps)
                
                completition(Int(kbps))
            }
            
        } catch (let e) {
            print(e)
        }
        
        
    }
    
    deinit {
        log.debug("search deinit")
    }


}
