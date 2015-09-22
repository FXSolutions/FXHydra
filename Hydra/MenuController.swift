//
//  MenuController.swift
//  Hydra
//
//  Created by Evgeny Abramov on 7/1/15.
//  Copyright (c) 2015 Evgeny Abramov. All rights reserved.
//

import UIKit

class MenuHeader: UIView {
    
    var firstNameLabel : UILabel!
    var lastNameLabel : UILabel!
    var avatarImage : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.avatarImage = UIImageView()
        self.avatarImage.frame = CGRectMake(15, 20, 60, 60)
        self.avatarImage.layer.masksToBounds = true
        self.avatarImage.layer.cornerRadius = 30.0
        self.addSubview(self.avatarImage)
        
        self.firstNameLabel = UILabel()
        self.firstNameLabel.frame = CGRectMake(90, 30, screenSizeWidth-100, 20)
        self.firstNameLabel.textColor = UIColor.whiteColor()
        self.firstNameLabel.textAlignment = NSTextAlignment.Left
        self.firstNameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        self.addSubview(self.firstNameLabel)
        
        
        self.lastNameLabel = UILabel()
        self.lastNameLabel.frame = CGRectMake(90, 50, screenSizeWidth-100, 20)
        self.lastNameLabel.textColor = UIColor.whiteColor()
        self.lastNameLabel.textAlignment = NSTextAlignment.Left
        self.lastNameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        self.addSubview(self.lastNameLabel)
        
        let separator = UIView(frame: CGRectMake(0, 105, screenSizeWidth, 1))
        separator.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        self.addSubview(separator)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MenuPlayer: UIView {
    
    var artistLabel : MarqueeLabel!
    var songLabel : MarqueeLabel!
    var albumCoverImage : UIImageView!
    var blurEffectViewZZ : UIVisualEffectView!
    
    var songSlider : UISlider!
    var leftSongTimeLabel : UILabel!
    var rightSongTimeLabel : UILabel!
    
    var nextButton : UIButton!
    var prevButton : UIButton!
    var playButton : UIButton!
    var pauseButton : UIButton!
    var tapedView : UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.blurEffectViewZZ = UIVisualEffectView(effect: blurEffect)
        self.blurEffectViewZZ.frame = CGRectMake(0, 0, screenSizeWidth, 100)
        self.blurEffectViewZZ.alpha = 0.5
        self.blurEffectViewZZ.userInteractionEnabled = true
        self.addSubview(self.blurEffectViewZZ)
        
        self.songLabel = MarqueeLabel()
        self.songLabel.frame = CGRectMake(50, 8, 200, 15)
        self.songLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        self.songLabel.textColor = UIColor.whiteColor()
        self.songLabel.text = "No song title"
        self.addSubview(self.songLabel)
        
        self.artistLabel = MarqueeLabel()
        self.artistLabel.frame = CGRectMake(50, 27, 200, 15)
        self.artistLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        self.artistLabel.textColor = UIColor.grayColor()
        self.artistLabel.text = "No artist"
        self.addSubview(self.artistLabel)
        
        self.albumCoverImage = UIImageView()
        self.albumCoverImage.frame = CGRectMake(7, 7, 36, 36)
        self.albumCoverImage.image = UIImage(named: "placeholder")
        self.albumCoverImage.userInteractionEnabled = true
        self.addSubview(self.albumCoverImage)
        
        let separator = UIView(frame: CGRectMake(0, 50, screenSizeWidth, 1))
        separator.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.15)
        self.addSubview(separator)
        
        self.songSlider = UISlider()
        self.songSlider.frame = CGRectMake(40, 60, (screenSizeWidth-60)-90, 40)
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let thumbImageNormal = UIImage(named: "ThumbVolume")
        songSlider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let trackLeftImage = UIImage(named: "minTrack")!
        let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
        songSlider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        
        let trackRightImage = UIImage(named: "maxTrack")!
        let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
        songSlider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        
        self.addSubview(self.songSlider)
        
        self.leftSongTimeLabel = UILabel()
        self.leftSongTimeLabel.frame = CGRectMake(5, 70, 30, 20)
        self.leftSongTimeLabel.textColor = UIColor.grayColor()
        self.leftSongTimeLabel.font = UIFont(name: "HelveticaNeue-Light", size: 11)
        self.leftSongTimeLabel.text = "00:00"
        self.addSubview(self.leftSongTimeLabel)
        
        self.rightSongTimeLabel = UILabel()
        self.rightSongTimeLabel.frame = CGRectMake(((screenSizeWidth-60)-80)+40, 70, 30, 20)
        self.rightSongTimeLabel.textColor = UIColor.grayColor()
        self.rightSongTimeLabel.font = UIFont(name: "HelveticaNeue-Light", size: 11)
        self.rightSongTimeLabel.text  = "00:00"
        self.addSubview(self.rightSongTimeLabel)
        
        self.userInteractionEnabled = true
        let gestureRec = UITapGestureRecognizer(target: self, action: "tapOnView")
        
        self.tapedView = UIView(frame: CGRectMake(0, 0, screenSizeWidth, 49))
        self.tapedView.backgroundColor = UIColor.clearColor()
        self.tapedView.userInteractionEnabled = true
        self.addSubview(tapedView)
        self.tapedView.addGestureRecognizer(gestureRec)
        
        
    }
    
    func tapOnView() {
        if HRPlayerManager.sharedInstance.items.count != 0 {
           HRInterfaceManager.sharedInstance.openPlayer()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class MenuController: UITableViewController {
    
    var menuBackground : UIImageView!
    var blurEffectView : UIVisualEffectView!
    var menuHeader : MenuHeader!
    var footerPlayer : MenuPlayer!
    var selectedIndex = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.menuHeader = MenuHeader(frame: CGRectMake(0, 0, screenSizeWidth, 120))
        self.addSubscribes()
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.tableHeaderView = self.menuHeader
        
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView.registerClass(HRMenuCell.self, forCellReuseIdentifier: "HRMenuCell")
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView.frame = self.view.frame
        
        self.tableView.backgroundView = self.blurEffectView
        
        HRDataManager.sharedInstance.getCurrentUserInfo()
        
        self.footerPlayer = MenuPlayer(frame: CGRectMake(0, screenSizeHeight-100, screenSizeWidth, 100))
        
        
        // shadow
        let shadowPath = UIBezierPath(rect: self.footerPlayer.bounds)
        self.footerPlayer.layer.masksToBounds = false
        self.footerPlayer.layer.shadowColor = UIColor.blackColor().CGColor
        self.footerPlayer.layer.shadowOffset = CGSizeMake(0.0, 5.0)
        self.footerPlayer.layer.shadowOpacity = 0.5
        self.footerPlayer.layer.shadowPath = shadowPath.CGPath
        
        // actions
        
        self.footerPlayer.songSlider.addTarget(self, action: "seekToSliderValue", forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.view.addSubview(self.footerPlayer)
        if selectedIndex > 0 {
            self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedIndex-1, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
        }
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - UI
    
    
    // MARK: - Tableview delegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = HRMenuCell()
        
        if indexPath.row == 0 {
            cell.iconImage.image = UIImage(named: "my_music")
            cell.menuTextLabel.text = "My music"
        } else if indexPath.row == 1 {
            cell.iconImage.image = UIImage(named: "menuDownloads")
            cell.menuTextLabel.text = "Downloads"
        } else if indexPath.row == 2 {
            cell.iconImage.image = UIImage(named: "albums")
            cell.menuTextLabel.text = "Albums"
        } else if indexPath.row == 3 {
            cell.iconImage.image = UIImage(named: "friendsIcon")
            cell.menuTextLabel.text = "Friends"
        } else if indexPath.row == 4 {
            cell.iconImage.image = UIImage(named: "groupsIcon")
            cell.menuTextLabel.text = "Groups"
        } else if indexPath.row == 5 {
            cell.iconImage.image = UIImage(named: "menuSettings")
            cell.menuTextLabel.text = "Settings"
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedIndex = indexPath.row+1
        
        if indexPath.row == 0 {
            HRInterfaceManager.sharedInstance.openMusicList()
        } else if indexPath.row == 1 {
            HRInterfaceManager.sharedInstance.openDownloads()
        } else if indexPath.row == 2 {
            HRInterfaceManager.sharedInstance.openAlbums()
        } else if indexPath.row == 3 {
            HRInterfaceManager.sharedInstance.openFriends()//openFriends
        } else if indexPath.row == 4 {
            HRInterfaceManager.sharedInstance.openGroups()
        } else if indexPath.row == 5 {
            HRInterfaceManager.sharedInstance.openSettings()
        }
        
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func addSubscribes() {
        
        HRDataManager.sharedInstance.currentUserInfo.listen(self) { (userModel) -> Void in
            dispatch.async.main({ () -> Void in
                
                self.menuHeader.firstNameLabel.text = userModel.first_name
                self.menuHeader.lastNameLabel.text = userModel.last_name
                
                self.menuHeader.avatarImage.hnk_setImageFromURL(NSURL(string: userModel.photoURL)!)
                
            })
            
        }
        
//        HRPlayerManager.sharedInstance.playSignal.listen(self) { (played) -> Void in
//            
//            dispatch.async.main({ () -> Void in
//                if (played == true) {
//                    self.footerPlayer.hidden = false
//                } else {
//                    self.footerPlayer.hidden = true
//                }
//            })
//            
//        }
        
        HRPlayerManager.sharedInstance.currentSongChange.listen(self, callback: { (audioItem) -> Void in
            dispatch.async.main({ () -> Void in
                self.footerPlayer.artistLabel.text = audioItem.artist
                self.footerPlayer.songLabel.text = audioItem.title
            })
        })
        
        HRPlayerManager.sharedInstance.currentSongTimePlayed.listen(self, callback: { (duration, timePlayed) -> Void in
            dispatch.async.main({ () -> Void in
                self.footerPlayer.songSlider.value = Float(timePlayed)/Float(duration)
                
                self.footerPlayer.leftSongTimeLabel.text = self.getTimeString(timePlayed)
                self.footerPlayer.rightSongTimeLabel.text = self.getTimeString(duration)
            })
        })
        
        HRPlayerManager.sharedInstance.coverChanged.listen(self) { (image) -> Void in
            dispatch.async.main({ () -> Void in
                self.footerPlayer.albumCoverImage.image = image
            })
        }
    
    }
    
    
    func getTimeString(totalSeconds:Int) -> String {
        
        let seconds = Int(totalSeconds % 60)
        let minutes = Int((totalSeconds / 60) % 60)
        
        if minutes < 10 {
            if seconds < 10 {
                return "0\(minutes):0\(seconds)"
            } else {
                return "0\(minutes):\(seconds)"
            }
        } else {
            if seconds < 10 {
                return "\(minutes):0\(seconds)"
            } else {
                return "\(minutes):\(seconds)"
            }
        }
        
    }
    
    func seekToSliderValue() {
        
        let song = HRPlayerManager.sharedInstance.currentItem
        
        if song != nil {
            let second = Int(Float(self.footerPlayer.songSlider.value) * Float(song.duration))
            
            HRPlayerManager.sharedInstance.queue.queuePlayer.playAtSecond(second)
        }
        
    }

    

}
