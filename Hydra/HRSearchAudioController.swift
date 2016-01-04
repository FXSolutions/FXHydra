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
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = self.footer
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
        cell.audioModel = audio
        cell.searchController = self
        
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
        
        self.footer.startProgress()
        self.audios = Array<HRAudioItemModel>()
        
        let audioSearch = VKRequest(method: "audio.search", andParameters: ["q":query,"auto_complete":1,"sort":2,"offset":self.audios.count])
        
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
    
    deinit {
        log.debug("search deinit")
    }


}
