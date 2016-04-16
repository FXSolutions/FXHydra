//
//  FXDownloadsController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/18/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXDownloadsController: UITableViewController {
    
    weak var viewModel : FXDownloadsViewModel?
    
    
    var allSongs = [FXAudioItemModel]()
    
    // MARK: - Init
    
    init(style: UITableViewStyle,bindedViewModel:FXDownloadsViewModel) {
        
        self.viewModel = bindedViewModel
        
        super.init(style: style)
        
        self.tabBarItem = UITabBarItem(title: "Downloads", image: UIImage(named: "tabbar_downloads"), tag: 0)
        
        self.navigationItem.title = "Downloads"
        
        self.tableView.registerClass(FXDefaultMusicCell.self, forCellReuseIdentifier: "FXDefaultMusicCell")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View states
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewStyle()
        
        self.updateFromDB()
        
        FXSignalsService.sharedManager().updateAfterDownload.listen(self) { (update) in
            self.updateFromDB()
        }
        
    }
    
    func updateFromDB() {
        
        FXDatabaseService.sharedManager().getAllDownloadsFromDB { (arrayOfSongs) in
            
            self.allSongs = arrayOfSongs
            
            dispatch.async.main({
                self.tableView.reloadData()
            })
            
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View customize
    
    override func viewWillAppear(animated: Bool) {
        
        self.animateTable()
        
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.allSongs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let audioModel = self.allSongs[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("FXDefaultMusicCell", forIndexPath: indexPath) as! FXDefaultMusicCell
        cell.bindedAudioModel = audioModel
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let musicModel = self.allSongs[indexPath.row]
        self.drawMusicCell(cell as! FXDefaultMusicCell, audioModel: musicModel)
        
    }
    
    func drawMusicCell(cell:FXDefaultMusicCell,audioModel:FXAudioItemModel) {
        
        cell.audioAristLabel.text = audioModel.artist
        cell.audioTitleLabel.text = audioModel.title
        cell.audioTimeLabel.text = audioModel.getDurationString()
        
        cell.downloadButton.hidden = true
        
//        cell.downloadButton.setImage(UIImage(named: "download_button"), forState: UIControlState.Normal)
//        cell.downloadButton.tintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        
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
        
        
    }
    
    ////
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        FXPlayerService.sharedManager().currentAudiosArray = self.allSongs
        FXPlayerService.sharedManager().currentAudioIndexInArray = indexPath.row
        
        FXPlayerService.sharedManager().startPlayAtIndex()
        
        self.tableView.updateWithBlock { (tableView) -> Void in
            tableView.reloadRow(UInt(indexPath.row), inSection: UInt(indexPath.section), withRowAnimation: UITableViewRowAnimation.None)
        }
        
        ///
        
        FXInterfaceService.sharedManager().openPlayer()
        
    }


}
