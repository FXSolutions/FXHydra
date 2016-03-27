//
//  FXPlayerPlaylistController.swift
//  FXHydra
//
//  Created by kioshimafx on 5/2/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXPlayerPlaylistController: UITableViewController {
    
    
    let bitrateImageDark = UIImage(named: "bitrate_background")?.imageByTintColor(UIColor ( red: 0.426, green: 0.4397, blue: 0.4529, alpha: 1.0))
    let bitrateImageBlue = UIImage(named: "bitrate_background")?.imageByTintColor(UIColor ( red: 0.0734, green: 0.6267, blue: 0.7817, alpha: 1.0))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Playlist"
        
        self.tableViewStyle()

        // register cell
        
        self.tableView.registerClass(FXDefaultMusicCell.self, forCellReuseIdentifier: "FXDefaultMusicCell")
        
        let closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(FXPlayerPlaylistController.closeControllerAction))
        self.navigationItem.leftBarButtonItem = closeButton
        
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FXPlayerService.sharedManager().currentAudiosArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let auidoModel = FXPlayerService.sharedManager().currentAudiosArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("FXDefaultMusicCell", forIndexPath: indexPath) as! FXDefaultMusicCell
        cell.bindedAudioModel = auidoModel
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let musicModel = FXPlayerService.sharedManager().currentAudiosArray[indexPath.row]
        self.drawMusicCell(cell as! FXDefaultMusicCell, audioModel: musicModel)
        
    }
    
    func drawMusicCell(cell:FXDefaultMusicCell,audioModel:FXAudioItemModel) {
        
        cell.audioAristLabel.text = audioModel.artist
        cell.audioTitleLabel.text = audioModel.title
        cell.audioTimeLabel.text = audioModel.getDurationString()
        
        cell.downloadButton.setImage(UIImage(named: "download_button"), forState: UIControlState.Normal)
        cell.downloadButton.tintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        
        ///
        
        if audioModel.bitrate > 0 {
            cell.audioBitrate.text = "\(audioModel.bitrate)"
            cell.bitRateBackgroundImage.image = self.bitrateImageBlue
        } else {
            cell.bitRateBackgroundImage.image = self.bitrateImageDark
            cell.audioBitrate.text = "●●●"
            
            audioModel.getBitrate { (bitrate) -> () in
                cell.audioBitrate.text = "\(bitrate)"
                cell.bitRateBackgroundImage.image = self.bitrateImageBlue
            }
        }
        
        
    }
    
    //MARK: - Actions
    
    func closeControllerAction() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

}
