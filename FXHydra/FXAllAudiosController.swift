//
//  FXAllAudiosController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/18/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit
import YYKit

class FXAllAudiosController: UITableViewController {
    
    var viewModel : FXAllAudiosViewModel?
    
    let bitrateImageDark = UIImage(named: "bitrate_background")?.imageByTintColor(UIColor ( red: 0.426, green: 0.4397, blue: 0.4529, alpha: 1.0))
    
    let bitrateImageBlue = UIImage(named: "bitrate_background")?.imageByTintColor(UIColor ( red: 0.0734, green: 0.6267, blue: 0.7817, alpha: 1.0))
    
    
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
                self.tableView.reloadData()
            }
        })

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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FXDefaultMusicCell", forIndexPath: indexPath) as! FXDefaultMusicCell
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
        
        let musicModel = self.viewModel?.audiosArray[indexPath.row]
        
        FXPlayerService.sharedManager().startPlayAudioModel(musicModel!)
        
    }
    
    // MARK: - Drawing cells

    func drawMusicCell(cell:FXDefaultMusicCell,audioModel:FXAudioItemModel) {
        
        cell.audioAristLabel.text = audioModel.artist
        cell.audioTitleLabel.text = audioModel.title
        cell.audioTimeLabel.text = audioModel.getDurationString()
        
        cell.downloadButton.setImage(UIImage(named: "download_button"), forState: UIControlState.Normal)
        cell.downloadButton.tintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        
        cell.bitRateBackgroundImage.image = self.bitrateImageDark
        cell.audioBitrate.text = "●●●"
        ///
        
        audioModel.getBitrate { (bitrate) -> () in
            cell.audioBitrate.text = "\(bitrate)"
            cell.bitRateBackgroundImage.image = self.bitrateImageBlue
        }
        
        
    }
    
    deinit {
        
        log.info("deinit ::: FXAllAudiosController")
        
    }


}
