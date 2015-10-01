//
//  HRGroupAudioController.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/28/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit

class HRGroupAudioController: UITableViewController {

    var audiosArray = Array<HRAudioItemModel>()
    var loading = false
    var groupModel : HRGroupModel!
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.loadMoreAudios()
        
        self.tableView.registerClass(HRGroupAudioCell.self, forCellReuseIdentifier: "HRGroupAudioCell")
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        //self.addLeftBarButton()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "refreshAudios", forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - load all audio
    
    func loadMoreAudios() {
        
        if loading == false {
            loading = true
            let getAudio = VKRequest(method: "audio.get", andParameters: ["owner_id":"-\(self.groupModel.id)","count":100,"offset":self.audiosArray.count], andHttpMethod: "GET")
            
            getAudio.executeWithResultBlock({ (response) -> Void in
                
                let json = response.json as! Dictionary<String,AnyObject>
                let items = json["items"] as! Array<Dictionary<String,AnyObject>>
                
                
                for audioDict in items {
                    
                    print(audioDict)
                    
                    let jsonAudioItem = JSON(audioDict)
                    let audioItemModel = HRAudioItemModel(json: jsonAudioItem)
                    
                    self.audiosArray.append(audioItemModel)
                    
                }
                
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
                self.loading = false
                
                }, errorBlock: { (error) -> Void in
                    // error
                    log.debug("ERRORRR BLYAT \(error)")
                    
            })
        }
        
    }
    
    func refreshAudios() {
        
        self.audiosArray.removeAll()
        self.loadMoreAudios()
        
    }
    
    // mark: - tableView delegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.audiosArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let audio = self.audiosArray[indexPath.row]
        
        let cell:HRGroupAudioCell = self.tableView.dequeueReusableCellWithIdentifier("HRGroupAudioCell", forIndexPath: indexPath) as! HRGroupAudioCell
        
        cell.audioAristLabel.text = audio.artist
        cell.audioTitleLabel.text = audio.title
        cell.audioModel = audio
        
        //cell.audioDurationTime.text = self.durationFormater(Double(audio.duration))
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        dispatch.async.main { () -> Void in
            
            let audioLocalModel = self.audiosArray[indexPath.row]
            
            HRPlayerManager.sharedInstance.items = self.audiosArray
            HRPlayerManager.sharedInstance.currentPlayIndex = indexPath.row
            HRPlayerManager.sharedInstance.playItem(audioLocalModel)
            
            self.presentViewController(PlayerController(), animated: true, completion: nil)
            
        }
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            //add code here for when you hit delete
        }
        
    }
    
    
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == self.audiosArray.count - 7 {
            self.loadMoreAudios()
        }
        
    }
    
    //MARK :- stuff
    
    func downloadAudio(model:HRAudioItemModel,progressView:UIProgressView) {
        
        HRDownloadManager.sharedInstance.downloadAudio(model) { (progress) -> () in
            
            dispatch.async.main({ () -> Void in
                log.debug("download progress = \(progress)")
                progressView.hidden = false
                progressView.setProgress(Float(progress), animated: true)
            })
            
        }
        
    }
    
    func durationFormater(duration:Double) -> String {
        
        let min = Int(floor(duration / 60))
        let sec = Int(floor(duration % 60))
        
        return "\(min):\(sec)"
        
    }
    
    func addLeftBarButton() {
        
        
        let button = UIBarButtonItem(image: UIImage(named: "menuHumb"), style: UIBarButtonItemStyle.Plain, target: self, action: "openMenu")
        self.navigationItem.leftBarButtonItem = button
        
    }
    
    func openMenu() {
        
        HRInterfaceManager.sharedInstance.openMenu()
        
    }
}
