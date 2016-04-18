//
//  FXPlayerController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/18/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit
import YYKit
import StreamingKit

class FXPlayerController: UIViewController {
    
    weak var viewModel : FXPlayerViewModel?
    
    // main
    
    var backgroundImage : UIImageView!
    var blurEffectView : UIVisualEffectView!
    
    //
    
    var songCoverContainer   : UIView!
    var controllersContainer : UIView!
    
    // song cover container
    
    var songCoverImage : UIImageView!
    
    // controllers container
    
    var songSlider          : UISlider!
    var songTimeLeftLabel   : AttributedLabel!
    var songTimeRightLabel  : AttributedLabel!
    
    var songTitleLabel      : MarqueeLabel!
    var songArtistLabel     : AttributedLabel!
    
    var addToDownloadButton     : UIButton!
    var prevSongButton          : UIButton!
    var playPauseButton         : UIButton!
    var nextSongButton          : UIButton!
    var recommendationButton    : UIButton!
    
    var volumeSlider        : UISlider!
    var volumeLeftImage     : UIImageView!
    var volumeRightImage    : UIImageView!
    
    // tool bar
    
    var toolBar : UIToolbar!
    var toolBarSeparator : UIView!
    
    // height 190
    
    var timerForUpdateDuration:NSTimer?
    
    // MARK: - Init
    
    init(bindedViewModel:FXPlayerViewModel) {
        
        self.viewModel = bindedViewModel
        
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View load
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor ( red: 0.3138, green: 0.3138, blue: 0.3138, alpha: 1.0 )
        
        self.backgroundImage = UIImageView()
        self.backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
    
        let blurEffectStatic = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffectStatic)
        
        ///////////////////////////////////////////////////////////////
        
        self.songCoverContainer = UIView()
        self.songCoverContainer.backgroundColor = UIColor.clearColor()
        
        self.songCoverImage = UIImageView()
        self.songCoverImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.songCoverImage.layer.masksToBounds = true
        
        ///////////////////////////////////////////////////////////////
        
        self.controllersContainer = UIView()
        self.controllersContainer.backgroundColor = UIColor.clearColor()
        
        ///////////////////////////////////////////////////////////////
        // song slider
        
        self.songSlider         = UISlider()
        
        /*
        self.songSlider.addTarget(self, action: "seekToSliderValue", forControlEvents: UIControlEvents.ValueChanged)
        */
        
        let globalTintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let trackLeftImage1         = UIImage(named: "min_slider_image")!.imageByTintColor(globalTintColor)
        let trackLeftResizable1     = trackLeftImage1!.resizableImageWithCapInsets(insets)
        self.songSlider.setMinimumTrackImage(trackLeftResizable1, forState: UIControlState.Normal)
        
        let trackRightImage1        = UIImage(named: "max_slider_image")!
        let trackRightResizable1    = trackRightImage1.resizableImageWithCapInsets(insets)
        self.songSlider.setMaximumTrackImage(trackRightResizable1, forState: UIControlState.Normal)
        
        self.songSlider.setThumbImage(UIImage(named: "track_slider_tumb")!.imageByTintColor(globalTintColor), forState: UIControlState.Normal)
        
        ///
        
        self.songTimeLeftLabel                  = AttributedLabel()
        self.songTimeLeftLabel.backgroundColor  = UIColor.clearColor()
        self.songTimeLeftLabel.font             = UIFont(name: "AvenirNext-Regular", size: 15)!
        self.songTimeLeftLabel.textColor        = UIColor.lightGrayColor()
        self.songTimeLeftLabel.contentAlignment = .Left
        
        self.songTimeRightLabel                     = AttributedLabel()
        self.songTimeRightLabel.backgroundColor     = UIColor.clearColor()
        self.songTimeRightLabel.font                = UIFont(name: "AvenirNext-Regular", size: 15)!
        self.songTimeRightLabel.textColor           = UIColor.lightGrayColor()
        self.songTimeRightLabel.contentAlignment    = .Right
        
        ///////////////////////////////////////////////////////////////
        /// titles and buttons
        
        self.songTitleLabel                 = MarqueeLabel()
        self.songTitleLabel.backgroundColor = UIColor.clearColor()
        self.songTitleLabel.textColor       = UIColor.whiteColor()
        self.songTitleLabel.textAlignment   = .Center
        self.songTitleLabel.font            = UIFont(name: "AvenirNext-Medium", size: 17)!
        
        self.songArtistLabel                    = AttributedLabel()
        self.songArtistLabel.contentAlignment   = .Center
        self.songArtistLabel.backgroundColor    = UIColor.clearColor()
        self.songArtistLabel.textColor          = UIColor.lightGrayColor()
        self.songArtistLabel.font               = UIFont(name: "AvenirNext-Regular", size: 15)!
        
        self.addToDownloadButton            = UIButton(type: UIButtonType.System)
        self.addToDownloadButton.tintColor  = globalTintColor
        self.prevSongButton                 = UIButton(type: UIButtonType.System)
        self.prevSongButton.tintColor       = globalTintColor
        self.nextSongButton                 = UIButton(type: UIButtonType.System)
        self.nextSongButton.tintColor       = globalTintColor
        self.playPauseButton                = UIButton(type: UIButtonType.System)
        self.playPauseButton.tintColor      = globalTintColor
        self.recommendationButton                 = UIButton(type: UIButtonType.System)
        self.recommendationButton.tintColor       = globalTintColor
        
        
        ///////////////////////////////////////////////////////////////
        /// volume
        
        self.volumeSlider = UISlider()
        
        let volumeLeftImage1        = UIImage(named: "min_slider_image")!.imageByTintColor(globalTintColor)
        let volumeLeftResizable1    = volumeLeftImage1!.resizableImageWithCapInsets(insets)
        self.volumeSlider.setMinimumTrackImage(volumeLeftResizable1, forState: UIControlState.Normal)
        
        let volumeRightImage1       = UIImage(named: "max_slider_image")!
        let volumeRightResizable1   = volumeRightImage1.resizableImageWithCapInsets(insets)
        self.volumeSlider.setMaximumTrackImage(volumeRightResizable1, forState: UIControlState.Normal)
        
        self.volumeSlider.setThumbImage(UIImage(named: "volume_slider_tumb")!.imageByTintColor(globalTintColor), forState: UIControlState.Normal)
        
        self.volumeLeftImage = UIImageView()
        self.volumeLeftImage.image = UIImage(named: "volume_down")?.imageByTintColor(UIColor.lightGrayColor())
        
        
        self.volumeRightImage = UIImageView()
        self.volumeRightImage.image = UIImage(named: "volume_up")?.imageByTintColor(UIColor.lightGrayColor())
        
        ///
        
        self.toolBar = UIToolbar()
        
        self.toolBarSeparator = UIView()
        self.toolBarSeparator.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.4)
        
        
        ///////////////////////////////////////////////////////////////
        /// add subview's
        ///////////////////////////////////////////////////////////////
        
        self.view.addSubview(self.backgroundImage)
        self.view.addSubview(self.blurEffectView)
        
        //
        
        self.view.addSubview(self.songCoverContainer)
        self.view.addSubview(self.controllersContainer)
        
        /// song cover
        
        self.songCoverContainer.addSubview(self.songCoverImage)
        
        /// controllers
        
        // song slider + song time
        self.controllersContainer.addSubview(self.songSlider)
        self.controllersContainer.addSubview(self.songTimeLeftLabel)
        self.controllersContainer.addSubview(self.songTimeRightLabel)
        
        // song name
        self.controllersContainer.addSubview(self.songTitleLabel)
        self.controllersContainer.addSubview(self.songArtistLabel)
        
        // prev/next/play/pause buttons
        self.controllersContainer.addSubview(self.addToDownloadButton)
        self.controllersContainer.addSubview(self.prevSongButton)
        self.controllersContainer.addSubview(self.playPauseButton)
        self.controllersContainer.addSubview(self.nextSongButton)
        self.controllersContainer.addSubview(self.recommendationButton)
        
        // volume changes :)
        self.controllersContainer.addSubview(self.volumeSlider)
        self.controllersContainer.addSubview(self.volumeLeftImage)
        self.controllersContainer.addSubview(self.volumeRightImage)
        
        /// toolbar
        
        self.toolBar.addSubview(self.toolBarSeparator)
        self.view.addSubview(self.toolBar)
        
    }

    
    // MARK: - View states

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // clean navbar
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        // nav bar title settings
        
        let titleDict = [NSFontAttributeName : UIFont(name: "Avenir-Book", size: 17)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        // load some stuff
        
        self.loadContent()
        
        self.loadNavButtons()
        self.loadCurrentAudioStateInfo()
        self.loadToolBar()
        
        ///
        
        self.bindedSignals()
        
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let viewSize = self.view.frame.size
        
        ///////////////////////////////////////////////////////////////
        // background
        
        self.backgroundImage.frame = self.view.frame
        self.blurEffectView.frame = self.view.frame
        
        ///////////////////////////////////////////////////////////////
        // containers
        
        self.controllersContainer.frame = CGRectMake(0, viewSize.height-190-44, viewSize.width, 190)
        
        let songCoverTop = (self.navigationController?.navigationBar.bottom)!
        let songCoverHeight = self.controllersContainer.top - songCoverTop
        
        self.songCoverContainer.frame = CGRectMake(0, (self.navigationController?.navigationBar.bottom)!, viewSize.width, songCoverHeight)
        
        ///////////////////////////////////////////////////////////////
        // cover
        
        let songContainterSize = self.songCoverContainer.frame.size
        let coverSize = songContainterSize.height - 15
        
        self.songCoverImage.frame = CGRectMake(songContainterSize.width/2-coverSize/2, songContainterSize.height/2-coverSize/2, coverSize, coverSize)
        
        ///////////////////////////////////////////////////////////////
        // controllers
        
        let contSize = self.controllersContainer.frame.size
        
        self.songSlider.frame = CGRectMake(10, 0, contSize.width-20, 20)
        self.songTimeLeftLabel.frame = CGRectMake(10, self.songSlider.bottom+5, 40, 20)
        self.songTimeRightLabel.frame = CGRectMake(self.songSlider.right-40, self.songSlider.bottom+5, 40, 20)
        
        ///////////////////////////////////////////////////////////////
        // artist/title
        
        let songTitleSize = contSize.width-80
        self.songTitleLabel.frame = CGRectMake(contSize.width/2-songTitleSize/2, self.songTimeLeftLabel.bottom + 10, songTitleSize, 20)
        
        let songArtistSize = contSize.width-80
        self.songArtistLabel.frame = CGRectMake(contSize.width/2-songArtistSize/2, self.songTitleLabel.bottom + 5, songArtistSize, 20)
        
        ///////////////////////////////////////////////////////////////
        // buttons
        

        self.playPauseButton.frame      = CGRectMake(contSize.width/2-10, self.songArtistLabel.bottom+25, 20, 20)
        self.prevSongButton.frame       = CGRectMake(self.playPauseButton.left-60, self.playPauseButton.centerY-10, 20, 20)
        self.nextSongButton.frame       = CGRectMake(self.playPauseButton.right+40, self.playPauseButton.centerY-10, 20, 20)
        
        self.addToDownloadButton.frame        = CGRectMake(self.prevSongButton.left-60, self.playPauseButton.centerY-10, 20, 20)
        self.recommendationButton.frame       = CGRectMake(self.nextSongButton.right+40, self.nextSongButton.centerY-12, 20, 20)
        
        
        ///////////////////////////////////////////////////////////////
        
        self.volumeSlider.frame         =  CGRectMake(40, contSize.height-30, contSize.width-80, 20)
        self.volumeLeftImage.frame = CGRectMake(15, self.volumeSlider.centerY-5, 10, 10)
        self.volumeRightImage.frame = CGRectMake(contSize.width-25, self.volumeSlider.centerY-5, 10, 10)
        
        ///////////////////////////////////////////////////////////////
        
        let sortaPixel = 1.0/UIScreen.mainScreen().scale
        self.toolBarSeparator.frame = CGRectMake(0, 0, viewSize.width, sortaPixel)
        
        ///////////////////////////////////////////////////////////////
        
        self.toolBar.frame = CGRectMake(0, viewSize.height-44, viewSize.width, 44)
        
    }
    
    // MARK: - Load audio state
    
    func loadContent() {
        
        self.backgroundImage.image = UIImage(named: "player_background_default")
        self.songCoverImage.image = UIImage(named: "player_background_default")
        
        // placeholders
        
        self.songTimeLeftLabel.text = "0:00"
        self.songTimeRightLabel.text = "0:00"
        
        self.songArtistLabel.text = "Anup Sastry"
        self.songTitleLabel.text = "Enigma"
        
        
        ///
        
        self.volumeSlider.value = FXPlayerService.sharedManager().audioPlayer.volume
        
        //////////////////////////////////////////////////////////////////////////////////////////
        
        let globalTintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        
        let downloadButtonImage = UIImage(named: "tabbar_downloads")?.imageByTintColor(globalTintColor)
        self.addToDownloadButton.setImage(downloadButtonImage, forState: UIControlState.Normal)
        
        let prevSongButtonIamge = UIImage(named: "rewind_arrows")?.imageByTintColor(globalTintColor)
        self.prevSongButton.setImage(prevSongButtonIamge, forState: UIControlState.Normal)
        
        let pauseButtonImage = UIImage(named: "pause_button")?.imageByTintColor(globalTintColor)
        self.playPauseButton.setImage(pauseButtonImage, forState: UIControlState.Normal)
        
        let nextSongButtonImage = UIImage(named: "forward_arrows")?.imageByTintColor(globalTintColor)
        self.nextSongButton.setImage(nextSongButtonImage, forState: UIControlState.Normal)
        
        let recommendationImage = UIImage(named: "button_recomend")?.imageByTintColor(globalTintColor)
        self.recommendationButton.setImage(recommendationImage, forState: UIControlState.Normal)
        
        // add actions on buttons
        
        self.playPauseButton.addTarget(self, action: #selector(FXPlayerController.playPauseButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.nextSongButton.addTarget(self, action: #selector(FXPlayerController.goToNextTrackInPlaylistAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.prevSongButton.addTarget(self, action: #selector(FXPlayerController.goToPrevTrackInPlaylistAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.recommendationButton.addTarget(self, action: #selector(FXPlayerController.openRecommendationsForCurrentAudio), forControlEvents: UIControlEvents.TouchUpInside)
        
        // volume
        
        self.volumeSlider.addTarget(self, action: #selector(FXPlayerController.changeVolumeSliderValue), forControlEvents: UIControlEvents.ValueChanged)
        self.volumeSlider.value = FXPlayerService.sharedManager().audioPlayer.volume
        
        // song slider
        self.songSlider.addTarget(self, action: #selector(FXPlayerController.stopUpdateTime), forControlEvents: UIControlEvents.TouchDown)
        self.songSlider.addTarget(self, action: #selector(FXPlayerController.seekSongToNewValue), forControlEvents: UIControlEvents.TouchUpInside)
        self.songSlider.addTarget(self, action: #selector(FXPlayerController.updateTimeOnSlide), forControlEvents: UIControlEvents.TouchDragInside)
        
    }
    
    func loadCurrentAudioStateInfo() {
        
        if FXPlayerService.sharedManager().currentAudioPlayed != nil {
            
            let audioModel = FXPlayerService.sharedManager().currentAudioPlayed
            
            self.songArtistLabel.text = audioModel!.artist
            self.songTitleLabel.text = audioModel!.title
            
            let index = FXPlayerService.sharedManager().currentAudioIndexInArray + 1
            let totalCount = FXPlayerService.sharedManager().currentAudiosArray.count
            
            self.title = "\(index) of \(totalCount)"
            
            
        }
        
        
    }
    
    func loadToolBar() {
        
        // style
        
        self.toolBar.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        //self.toolBar.setShadowImage(UIImage().imageByTintColor(UIColor.whiteColor()), forToolbarPosition: UIBarPosition.Any)
        self.toolBar.translucent = true
        self.toolBar.backgroundColor = UIColor.clearColor()
        self.toolBar.tintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        self.toolBar.clipsToBounds = true
        
        
        /*
        whiteToolBar.layer.borderWidth = 1;
        whiteToolBar.layer.borderColor = [[UIColor whiteColor] CGColor];
        */
        
        // items
        
        var items = [UIBarButtonItem]()
        
        //
        
        let flexSpaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let equalizer = UIBarButtonItem(image: UIImage(named: "toolbar_equalizer"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(FXPlayerController.openEqualizer))
        
        let flexSpaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        //
        
        items.append(flexSpaceLeft)
        items.append(equalizer)
        items.append(flexSpaceRight)
        
        self.toolBar.setItems(items, animated: false)
        
    }
    
    func bindedSignals() {
        
        // change state 
        
        FXSignalsService.sharedManager().playedStateChangedOnPlaying.listen(self) { (played) in
            
            
            let globalTintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
            
            if played == true {
                
                dispatch.async.main({
                    let pauseButtonImage = UIImage(named: "pause_button")?.imageByTintColor(globalTintColor)
                    self.playPauseButton.setImage(pauseButtonImage, forState: UIControlState.Normal)
                    
                    
                    //
                    
                    self.startUpdateTime()
                    
                })
                
            } else {
                
                dispatch.async.main({
                    let playButtonImage = UIImage(named: "play_button")?.imageByTintColor(globalTintColor)
                    self.playPauseButton.setImage(playButtonImage, forState: UIControlState.Normal)
                    
                    if self.timerForUpdateDuration != nil {
                        
                        self.timerForUpdateDuration?.invalidate()
                        
                    }
                    
                })
                
            }
            
        }
    
        /// update current audio item
        
        FXSignalsService.sharedManager().changeCurrentItem.listen(self) { (audioModel) in
            
            dispatch.async.main({
                self.loadCurrentAudioStateInfo()
            })
            
        }
        
        /// update cover
        
        FXSignalsService.sharedManager().updateCoverImage.listen(self) { (coverImage) in
            
            dispatch.async.main({
                self.songCoverImage.image = coverImage
                self.backgroundImage.image = coverImage
            })
            
        }
        
    }
    
    func startUpdateTime() {
        
        if self.timerForUpdateDuration != nil {
            
            self.timerForUpdateDuration?.invalidate()
            
        }
        
        self.timerForUpdateDuration = NSTimer.scheduledTimerWithTimeInterval(1,
                                                                             target: self,
                                                                             selector: #selector(FXPlayerController.updateTimeFromTimer),
                                                                             userInfo: nil,
                                                                             repeats: true)
        
        self.timerForUpdateDuration?.fire()
    }
    
    func stopUpdateTime() {
        
        if self.timerForUpdateDuration != nil {
            
            self.timerForUpdateDuration?.invalidate()
            
        }
        
    }
    
    func updateTimeOnSlide() {
        
        let seekTime = FXPlayerService.sharedManager().audioPlayer.duration * Double(self.songSlider.value)
        
        self.songTimeLeftLabel.text = self.getDurationString(seekTime)
        
    }
    
    func seekSongToNewValue() {
        
        let seekTime = FXPlayerService.sharedManager().audioPlayer.duration * Double(self.songSlider.value)
        
        FXPlayerService.sharedManager().audioPlayer.seekToTime(seekTime)
        
        self.startUpdateTime()
        
    }
    
    func updateTimeFromTimer() {
        
        let progress = self.getDurationString(FXPlayerService.sharedManager().audioPlayer.progress)
        let duration = self.getDurationString(FXPlayerService.sharedManager().audioPlayer.duration)
        
        let valueForProgress = FXPlayerService.sharedManager().audioPlayer.progress/FXPlayerService.sharedManager().audioPlayer.duration
        self.songSlider.value = Float(valueForProgress)
        
        self.songTimeLeftLabel.text = "\(progress)"
        self.songTimeRightLabel.text = "\(duration)"
        
    }
    
    // MARK: - UI Customized
    
    func loadNavButtons() {
        
        let closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(FXPlayerController.closeControllerAction))
        self.navigationItem.leftBarButtonItem = closeButton
        
        ///
        
        let actionsButton = UIBarButtonItem(title: "Actions", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(FXPlayerController.navButtonActionsAction))
        self.navigationItem.rightBarButtonItem = actionsButton
        
    }
    
    // MARK: - Actions
    
    func closeControllerAction() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func navButtonActionsAction() {
        
        log.debug("::: navButtonActionsAction :::")
        
        /////////////////////////////////////////////
        
        ZAlert.actionSheet("", message: "").action("Add to Playlist", style: UIAlertActionStyle.Default) { (action) in
            //
        }.action("Add in VK", style: UIAlertActionStyle.Default, handler: { (action) in
            //
        }).action("Close", style: UIAlertActionStyle.Cancel) { (action) in
            //
        }.present(self, animated: true, completion: nil)
        
    }
    
    func openEqualizer() {
        
        log.debug("::: openEqualizer :::")
        
    }
    
    func openPlaylist() {
        
        
        log.debug("::: open playlist :::")
        
        let playlistVC = FXNavigationController(rootViewController: FXPlayerPlaylistController())
        
        self.presentViewController(playlistVC, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Play/Pause/Next Prev
    
    func playPauseButtonAction() {
        
        let state = FXPlayerService.sharedManager().audioPlayer.state
        
        if state == STKAudioPlayerState.Playing {
            FXPlayerService.sharedManager().audioPlayer.pause()
        } else {
            FXPlayerService.sharedManager().audioPlayer.resume()
        }
        
    }
    
    func goToNextTrackInPlaylistAction() {
        
        FXPlayerService.sharedManager().playNextAudio()
        
    }
    
    func goToPrevTrackInPlaylistAction() {
        
        FXPlayerService.sharedManager().playPrevAudio()
        
    }
    
    func changeVolumeSliderValue() {
        
        FXPlayerService.sharedManager().audioPlayer.volume = self.volumeSlider.value
        
    }
    
    func getDurationString(duration:Double) -> String {
        
        let min = Int(floor(Double(duration) / 60))
        let sec = Int(floor(Double(duration) % 60))
        
        if (sec < 10) {
            return "\(min):0\(sec)"
        } else {
            return "\(min):\(sec)"
        }
        
    }
    
    func openRecommendationsForCurrentAudio() {
        
        if FXPlayerService.sharedManager().currentAudioPlayed != nil {
            
            let currentAudio = FXPlayerService.sharedManager().currentAudioPlayed
            let target_string = "\(currentAudio!.ownerID!)_\(currentAudio!.audioID!)"
            
            let recommVC = FXRecommendationsController(style: UITableViewStyle.Plain, target: target_string)
            
            self.navigationController?.pushViewController(recommVC, animated: true)
            
            
        }
        
    }
    

}
