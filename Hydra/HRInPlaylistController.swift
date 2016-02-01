//
//  HRInAlbumController.swift
//  Hydra
//
//  Created by Evgeny Abramov on 8/3/15.
//  Copyright © 2015 Evgeny Abramov. All rights reserved.
//

import UIKit
import VK_ios_sdk

class HRInPlaylistController: UITableViewController {

    var audiosArray = Array<HRAudioItemModel>()
    var loading = false
    var album_id : Int!
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.loadMoreAudios()
        
        self.tableView.registerClass(HRAllMusicCell.self, forCellReuseIdentifier: "HRAllMusicCell")
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        self.addLeftBarButton()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    
    // MARK: - load all audio
    
    
    func loadMoreAudios() {
        
        if loading == false {
            loading = true
            let getAudio = VKRequest(method: "audio.get", parameters: ["count":100,"offset":self.audiosArray.count,"album_id":self.album_id])
            
            getAudio.executeWithResultBlock({ (response) -> Void in
                
                let json = response.json as! Dictionary<String,AnyObject>
                let items = json["items"] as! Array<Dictionary<String,AnyObject>>
                
                
                for audioDict in items {
                    
                    print(audioDict)
                    
                    let jsonAudioItem = JSON(audioDict)
                    let audioItemModel = HRAudioItemModel(json: jsonAudioItem)
                    
                    self.audiosArray.append(audioItemModel)
                    
                }
                
                self.tableView.reloadData()
                self.loading = false
                
                }, errorBlock: { (error) -> Void in
                    // error
                    print(error)
            })
        }
        
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
        
        let cell:HRAllMusicCell = self.tableView.dequeueReusableCellWithIdentifier("HRAllMusicCell", forIndexPath: indexPath) as! HRAllMusicCell
        
        cell.audioAristLabel.text = audio.artist
        cell.audioTitleLabel.text = audio.title
        
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
        
        //        self.presentViewController(PlayerController(), animated: true) { () -> Void in
        //            dispatch.async.main { () -> Void in
        //                var audioLocalModel = self.audiosArray[indexPath.row]
        //
        //                HRPlayerManager.sharedInstance.playItem(audioLocalModel)
        //
        //            }
        //        }
        
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
    
    func durationFormater(duration:Double) -> String {
        
        let min = Int(floor(duration / 60))
        let sec = Int(floor(duration % 60))
        
        return "\(min):\(sec)"
        
    }
    
    func addLeftBarButton() {
        
        let button = UIBarButtonItem(image: UIImage(named: "backButton")?.imageWithColor2(UIColor.whiteColor()), style: UIBarButtonItemStyle.Plain, target: self, action: "backButtonAction")
        self.navigationItem.leftBarButtonItem = button
        
    }
    
    func backButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func openMenu() {
        
        HRInterfaceManager.sharedInstance.openMenu()
        
    }
    
}
