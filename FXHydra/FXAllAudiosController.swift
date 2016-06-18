//
//  FXAllAudiosController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/18/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit
import YYKit
import ESTMusicIndicator

class FXAllAudiosController: UITableViewController {
    
    var viewModel : FXAllAudiosViewModel?
    
    //
    
    var searchController : UISearchController?
    
    // FIX IT : going to another public static class
    
    
    // MARK: - Init
    
    init(style: UITableViewStyle,bindedViewModel:FXAllAudiosViewModel) {
        
        super.init(style: style)
        
        self.viewModel = bindedViewModel
        
        self.tabBarItem = UITabBarItem(title: "Audios", image: UIImage(named: "tabbar_allmusic"), tag: 0)
        
        self.navigationItem.title = "Audios"
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View states

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewStyle()
        
        // register cell
        
        self.tableView.registerClass(FXDefaultMusicCell.self, forCellReuseIdentifier: "FXDefaultMusicCell")
        
        // load data
        
        self.viewModel?.getAudios({ (compite) -> () in
            if compite == true {
                self.animateTable()
            }
        })
        
        /// add search
        
        let searchAudioController = FXSearchAudiosController()
        self.searchController = UISearchController(searchResultsController: searchAudioController)
        self.searchController?.searchResultsUpdater = searchAudioController
        self.searchController?.searchBar.sizeToFit()
        self.searchController?.searchBar.tintColor = UIColor ( red: 0.882, green: 0.8778, blue: 0.8863, alpha: 1.0 )
        self.searchController?.searchBar.backgroundColor = UIColor ( red: 0.2228, green: 0.2228, blue: 0.2228, alpha: 1.0 )
        self.searchController?.searchBar.barTintColor = UIColor ( red: 0.1221, green: 0.1215, blue: 0.1227, alpha: 1.0 )
        self.searchController?.searchBar.backgroundImage = UIImage()
        self.searchController?.searchBar.placeholder = ""
        self.searchController?.searchBar.inputAccessoryView?.backgroundColor = UIColor ( red: 0.3025, green: 0.301, blue: 0.3039, alpha: 1.0 )
        self.searchController?.searchBar.keyboardAppearance = .Dark
        self.searchController?.searchBar.translucent = false
        
        let txfSearchField = self.searchController?.searchBar.valueForKey("_searchField") as! UITextField
        txfSearchField.backgroundColor = UIColor ( red: 0.0732, green: 0.0728, blue: 0.0735, alpha: 1.0 )
        txfSearchField.textColor = UIColor.whiteColor()
        
        self.tableView.tableHeaderView = self.searchController?.searchBar
        
        self.tableView.tableHeaderView?.backgroundColor = UIColor ( red: 0.1221, green: 0.1215, blue: 0.1227, alpha: 1.0 )
        
        self.tableView.backgroundView = UIView()
        
        FXSignalsService.sharedManager().updateAfterDownload.listen(self) { (update) in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.animateTable()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    func animateTable() {
        
        self.tableView.reloadData()
        
        ////
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(0.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View customize 
    
    func tableViewStyle() {
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0)
        self.tableView.indicatorStyle = UIScrollViewIndicatorStyle.White
        
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.tableView.backgroundColor = UIColor ( red: 0.2228, green: 0.2228, blue: 0.2228, alpha: 1.0 )
        self.tableView.separatorColor = UIColor ( red: 0.2055, green: 0.2015, blue: 0.2096, alpha: 1.0 )
        
        self.view.backgroundColor = UIColor ( red: 0.1221, green: 0.1215, blue: 0.1227, alpha: 1.0 )
        
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel!.audiosArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let auidoModel = self.viewModel?.audiosArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("FXDefaultMusicCell", forIndexPath: indexPath) as! FXDefaultMusicCell
        cell.bindedAudioModel = auidoModel
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    
        let musicModel = self.viewModel?.audiosArray[indexPath.row]
        self.drawMusicCell(cell as! FXDefaultMusicCell, audioModel: musicModel!)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        FXPlayerService.sharedManager().currentAudiosArray = (self.viewModel?.audiosArray)!
        FXPlayerService.sharedManager().currentAudioIndexInArray = indexPath.row
        
        FXPlayerService.sharedManager().startPlayAtIndex()
        
        self.tableView.updateWithBlock { (tableView) -> Void in
            tableView.reloadRow(UInt(indexPath.row), inSection: UInt(indexPath.section), withRowAnimation: UITableViewRowAnimation.None)
        }
        
        ///
        
        FXInterfaceService.sharedManager().openPlayer()
        
    }
    
    // MARK: - Drawing cells

    func drawMusicCell(cell:FXDefaultMusicCell,audioModel:FXAudioItemModel) {
        
        cell.audioAristLabel.text = audioModel.artist
        cell.audioTitleLabel.text = audioModel.title
        cell.audioTimeLabel.text = audioModel.getDurationString()
        
        if FXDataService.sharedManager().checkAudioIdInDownloads(audioModel.audioID) == false {
            
            cell.downloadButton.setImage(UIImage(named: "download_button"), forState: UIControlState.Normal)
            cell.downloadButton.tintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
            cell.downloadButton.addTarget(self, action: #selector(FXAllAudiosController.startDownload(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
        } else {
        
            cell.downloadButton.hidden = true
        
        }
        
        ///
        
        if audioModel.bitrate > 0 {
            cell.audioBitrate.text = "\(audioModel.bitrate)"
            cell.bitRateBackgroundImage.image = bitrateImageBlue
        } else {
            cell.bitRateBackgroundImage.image = bitrateImageDark
            cell.audioBitrate.text = "●●●"
            
            audioModel.getBitrate { (bitrate) -> () in
                cell.audioBitrate.text = "\(bitrate)"
                cell.bitRateBackgroundImage.image = bitrateImageBlue
            }
        }
        
        ///
        
        
    }
    
    func startDownload(sender:AnyObject?) {
        
        log.debug("::: sender \(sender) :::")
        let superView = sender?.superview!!.superview as! FXDefaultMusicCell
        let audioModel = superView.bindedAudioModel
        
        FXDownloadsPoolService.sharedManager().downloadAudioOnLocalStorage(audioModel)
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let musicModel = self.viewModel?.audiosArray[indexPath.row]
        return FXDataService.sharedManager().checkAudioIdInDownloads(musicModel!.audioID)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction.init(style: .Default, title: "Delete") { (action, indexPath) in
            let index = indexPath.row
            let model = self.viewModel?.audiosArray[index]
            
            FXDatabaseService.sharedManager().getDownloadModelWithID(model!.audioID, cb: { (song) in
                if song != nil {
                    
                    if FXPlayerService.sharedManager().currentAudioIndexInArray == index {
                        let state = FXPlayerService.sharedManager().audioPlayer.state
                        if state == .Playing {
                            FXPlayerService.sharedManager().audioPlayer.pause()
                        }
                    }
                    
                    FXDatabaseService.sharedManager().deleteDownloadModel(song!, cb: { (completed) in
                        if completed {
                            FXDataService.sharedManager().loadAllDownloads({ (done) in
                                dispatch.async.main({
                                    FXSignalsService.sharedManager().updateAfterDownload.fire(true)
                                })
                            })
                        }
                    })
                }
            })
            
            
            
        }
        deleteButton.backgroundColor = UIColor.init(RGB: 0xd72d2d)
        return [deleteButton]
    }
    
    deinit {
        
        log.info("deinit ::: FXAllAudiosController")
        
    }


}
