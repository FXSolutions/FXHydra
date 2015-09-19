//
//  PlayerController.swift
//  Hydra
//
//  Created by Evgeny Abramov on 7/1/15.
//  Copyright (c) 2015 Evgeny Abramov. All rights reserved.
//

import UIKit
import Haneke

class PlayerController: UIViewController {
    
    // title
    var songsCountLabel : UILabel!
    
    var closeButton : UIButton!
    var songTitleLabel: MarqueeLabel!
    var songArtistLabel: UILabel!
    
    // background
    var backgroundImage : UIImageView!
    var songImage : UIImageView!
    var blurEffectView : UIVisualEffectView!
    
    var playButton : UIButton!
    var pauseButton : UIButton!
    var nextSondButton : UIButton!
    var prevSoundButton : UIButton!
    
    // volume
    var volumeView  : MPVolumeView!
    var volumeLeftImage : UIImageView!
    var volumeRightImage : UIImageView!
    
    // song slider
    var songSlider : UISlider!
    var songTimeLeftLabel : UILabel!
    var songTimeRightLabel : UILabel!
    
    // buttons
    var repeatButton : UIButton!
    var addButton : UIButton!
    var broadcastButton : UIButton!
    var shuffleButton : UIButton!
    
    
    override func loadView() {
        super.loadView()
        
        self.backgroundImage = UIImageView()
        self.backgroundImage.frame = self.view.frame
        self.view.addSubview(self.backgroundImage)
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView.frame = self.view.frame
        self.view.addSubview(self.blurEffectView)
        
        
        self.songImage = UIImageView()
        self.songImage.frame = CGRectMake(screenSizeWidth/2-145, 100, 290, 290)
        self.view.addSubview(self.songImage)
        
        self.backgroundImage.image = UIImage(named: "placeholderBackground")
        
        self.songImage.image = UIImage(named: "placeholder")
        
        self.closeButton = UIButton()
        self.closeButton.addTarget(self, action: "closeAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.closeButton.setImage(UIImage(named: "minimize"), forState: UIControlState.Normal)
        self.closeButton.titleLabel?.textAlignment = NSTextAlignment.Left
        self.closeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.closeButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        self.closeButton.frame = CGRectMake(10, 30, 25,25)
        self.view.addSubview(self.closeButton)
        //self.closeButton.backgroundColor = UIColor.whiteColor()
        
        self.songsCountLabel = UILabel()
        self.songsCountLabel.frame = CGRectMake(screenSizeWidth/2-125, 30, 250, 30)
        self.songsCountLabel.textColor = UIColor.whiteColor()
        self.songsCountLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.songsCountLabel)
        
        self.songTitleLabel = MarqueeLabel()
        self.songTitleLabel.frame = CGRectMake(screenSizeWidth/2-125, screenSizeHeight-180, 250, 20)
        self.songTitleLabel.textColor = UIColor.whiteColor()
        self.songTitleLabel.font = UIFont(name: "Helvetica Neue Medium", size: 17)
        self.songTitleLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.songTitleLabel)
        
        self.songArtistLabel = UILabel()
        self.songArtistLabel.frame = CGRectMake(screenSizeWidth/2-125, screenSizeHeight-160, 250, 20)
        self.songArtistLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        self.songArtistLabel.textColor = UIColor.grayColor()
        self.songArtistLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.songArtistLabel)
        
        self.songsCountLabel = UILabel()
        self.songsCountLabel.frame = CGRectMake(screenSizeWidth/2-125, 30, 250, 30)
        self.songsCountLabel.textColor = UIColor.whiteColor()
        self.songsCountLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.songsCountLabel)
        
        self.playButton = UIButton()
        self.playButton.frame = CGRectMake(screenSizeWidth/2-22.5, screenSizeHeight-125, 45, 45)
        self.playButton.setImage(UIImage(named: "play"), forState: UIControlState.Normal)
        self.playButton.addTarget(self, action: "playAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.playButton)
        
        self.pauseButton  = UIButton()
        self.pauseButton.frame = CGRectMake(screenSizeWidth/2-22.5, screenSizeHeight-125, 45, 45)
        self.pauseButton.setImage(UIImage(named: "pause"), forState: UIControlState.Normal)
        self.pauseButton.addTarget(self, action: "pauseAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.pauseButton)
        
        self.nextSondButton = UIButton()
        self.nextSondButton.frame = CGRectMake(screenSizeWidth/2+80-22.5, screenSizeHeight-125, 45, 45)
        self.nextSondButton.setImage(UIImage(named: "moveNext"), forState: UIControlState.Normal)
        self.nextSondButton.addTarget(self, action: "nextAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.nextSondButton)
        
        self.prevSoundButton = UIButton()
        self.prevSoundButton.frame = CGRectMake(screenSizeWidth/2-80-22.5, screenSizeHeight-125, 45, 45)
        self.prevSoundButton.setImage(UIImage(named: "movePrev"), forState: UIControlState.Normal)
        self.prevSoundButton.addTarget(self, action: "prevAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.prevSoundButton)
        
        
        self.repeatButton = UIButton()
        self.repeatButton.frame = CGRectMake(screenSizeWidth/2-145, 410, 30, 30)
        self.repeatButton.setImage(UIImage(named: "refresh"), forState: UIControlState.Normal)
        self.repeatButton.addTarget(self, action: "actionRepeat", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.repeatButton)
        
        self.addButton = UIButton()
        self.addButton.frame = CGRectMake(screenSizeWidth/2-50, 410, 30, 30)
        self.addButton.setImage(UIImage(named: "add_big"), forState: UIControlState.Normal)
        self.addButton.addTarget(self, action: "actionAdd", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.addButton)
        
        self.broadcastButton = UIButton()
        self.broadcastButton.frame = CGRectMake(screenSizeWidth/2+30, 410, 30, 30)
        self.broadcastButton.setImage(UIImage(named: "stream"), forState: UIControlState.Normal)
        self.broadcastButton.addTarget(self, action: "actionBroadcast", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.broadcastButton)
        
        self.shuffleButton = UIButton()
        self.shuffleButton.frame = CGRectMake(screenSizeWidth/2+125, 410, 30, 30)
        self.shuffleButton.setImage(UIImage(named: "shuffle"), forState: UIControlState.Normal)
        self.shuffleButton.addTarget(self, action: "adtionShuffle", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.shuffleButton)
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.songSlider = UISlider()
        self.songSlider.frame = CGRectMake(screenSizeWidth/2-125, 445 , 250, 30)
        let trackLeftImage1 = UIImage(named: "minTrack")!
        let trackLeftResizable1 = trackLeftImage1.resizableImageWithCapInsets(insets)
        self.songSlider.setMinimumTrackImage(trackLeftResizable1, forState: UIControlState.Normal)
        
        let trackRightImage1 = UIImage(named: "maxTrack")!
        let trackRightResizable1 = trackRightImage1.resizableImageWithCapInsets(insets)
        self.songSlider.setMaximumTrackImage(trackRightResizable1, forState: UIControlState.Normal)
        self.songSlider.setThumbImage(UIImage(named: "ThumbImage"), forState: UIControlState.Normal)
        
        self.songSlider.addTarget(self, action: "seekToSliderValue", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(self.songSlider)
        
        self.songTimeLeftLabel = UILabel()
        self.songTimeLeftLabel.frame = CGRectMake(screenSizeWidth/2-160, 445, 35, 30)
        self.songTimeLeftLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        self.songTimeLeftLabel.textColor = UIColor.grayColor()
        self.songTimeLeftLabel.textAlignment = NSTextAlignment.Left
        self.view.addSubview(self.songTimeLeftLabel)
        
        self.songTimeRightLabel = UILabel()
        self.songTimeRightLabel.frame = CGRectMake(screenSizeWidth/2+130, 445, 35, 30)
        self.songTimeRightLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        self.songTimeRightLabel.textColor = UIColor.grayColor()
        self.songTimeRightLabel.textAlignment = NSTextAlignment.Left
        self.view.addSubview(self.songTimeRightLabel)

        self.volumeView = MPVolumeView()
        self.volumeView.frame = CGRectMake(screenSizeWidth/2-125, screenSizeHeight-45, 250, 30)
        
        volumeView.backgroundColor = UIColor.clearColor()
        volumeView.showsVolumeSlider = true
        volumeView.showsRouteButton = false
        
        let thumbImageNormal = UIImage(named: "ThumbVolume")
        volumeView.setVolumeThumbImage(thumbImageNormal, forState: .Normal)
        
        let trackLeftImage = UIImage(named: "minTrack")!
        let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
        volumeView.setMinimumVolumeSliderImage(trackLeftResizable, forState: .Normal)
        
        let trackRightImage = UIImage(named: "maxTrack")!
        let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
        volumeView.setMaximumVolumeSliderImage(trackRightResizable, forState: .Normal)
        
        self.view.addSubview(self.volumeView)
        
        self.volumeLeftImage = UIImageView()
        self.volumeLeftImage.frame = CGRectMake(screenSizeWidth/2-125-20, screenSizeHeight-45, 20, 20)
        self.volumeLeftImage.image = UIImage(named: "less")
        self.view.addSubview(self.volumeLeftImage)
        
        self.volumeRightImage = UIImageView()
        self.volumeRightImage.frame = CGRectMake(screenSizeWidth/2+125+5, screenSizeHeight-46, 20, 20)
        self.volumeRightImage.image = UIImage(named: "more")
        self.view.addSubview(self.volumeRightImage)
    
        self.view.backgroundColor = UIColor.clearColor()
        
        
        if HRPlayerManager.sharedInstance.broadcastState == true {
            self.broadcastButton.setImage(UIImage(named: "stream")?.imageWithColor(UIColor.redColor()), forState: UIControlState.Normal)
        } else {
            self.broadcastButton.setImage(UIImage(named: "stream")?.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Normal)
        }
    
        if HRPlayerManager.sharedInstance.shuffleState == true {
            self.shuffleButton.setImage(UIImage(named: "shuffle")?.imageWithColor(UIColor.redColor()), forState: UIControlState.Normal)
        } else {
            self.shuffleButton.setImage(UIImage(named: "shuffle")?.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Normal)
        }

        if HRPlayerManager.sharedInstance.repeatState == true {
            self.repeatButton.setImage(UIImage(named: "repeatOne")?.imageWithColor(UIColor.redColor()), forState: UIControlState.Normal)
        } else {
            self.repeatButton.setImage(UIImage(named: "refresh")?.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Normal)
        }
        
    }
    
    // actions
    func pauseAction() {
        HRPlayerManager.sharedInstance.pause()
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.pauseButton.alpha = 0.0
            self.playButton.alpha = 1.0
            self.playButton.enabled = true
            self.pauseButton.enabled = false
        }
    }
    
    func playAction() {
        HRPlayerManager.sharedInstance.playCurrent()
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.pauseButton.alpha = 1.0
            self.playButton.alpha = 0.0
            self.playButton.enabled = false
            self.pauseButton.enabled = true
        }
    }
    
    func nextAction() {
        HRPlayerManager.sharedInstance.playNext()
    }
    
    func prevAction() {
        HRPlayerManager.sharedInstance.playPrev()
    }
    
    func swipeGesture(gesture:UISwipeGestureRecognizer) {
        
    }
    
    // controller load states
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playButton.alpha = 0.0
        
        self.setCurrentSong()
        self.subscribeUpdates()
        
        let swipeGestureOnAudioLeft = UISwipeGestureRecognizer(target: self, action: "nextAction")
        swipeGestureOnAudioLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeGestureOnAudioLeft)
        
        let swipeGestureOnAudioRight = UISwipeGestureRecognizer(target: self, action: "prevAction")
        swipeGestureOnAudioRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeGestureOnAudioRight)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func setCurrentSong() {
        let song = HRPlayerManager.sharedInstance.items[HRPlayerManager.sharedInstance.currentPlayIndex]
        
        self.songArtistLabel.text = song.artist
        self.songTitleLabel.text = song.title
        self.songsCountLabel.text = "\(HRPlayerManager.sharedInstance.currentPlayIndex+1) из \(HRPlayerManager.sharedInstance.items.count)"
        self.songTimeLeftLabel.text = "00:00"
        self.songTimeRightLabel.text = "00:00"
        self.songImage.image = HRPlayerManager.sharedInstance.coverImage
        self.backgroundImage.image = HRPlayerManager.sharedInstance.backgroundImage
        
    }
    
    func subscribeUpdates() {
        
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            HRPlayerManager.sharedInstance.currentSongChange.listen(self!, callback: { (audioItem) -> Void in
                dispatch.async.main({ () -> Void in
                    self!.songArtistLabel.text = audioItem.artist
                    self!.songTitleLabel.text = audioItem.title
                    self?.songsCountLabel.text = "\(HRPlayerManager.sharedInstance.currentPlayIndex+1) из \(HRPlayerManager.sharedInstance.items.count)"
                    
                    self?.addButton.enabled = true
                })
            })
            
            HRPlayerManager.sharedInstance.currentSongTimePlayed.listen(self!, callback: { (duration, timePlayed) -> Void in
                dispatch.async.main({ () -> Void in
                    log.debug("duration = \(duration) timeplayed = \(timePlayed)")
                    self!.songSlider.value = Float(timePlayed)/Float(duration)
                    
                    self?.songTimeLeftLabel.text = self?.getTimeString(timePlayed)
                    self?.songTimeRightLabel.text = self?.getTimeString(duration)
                })
            })
            
            HRPlayerManager.sharedInstance.coverChanged.listen(self!, callback: { (image) -> Void in
                dispatch.async.main({ () -> Void in
                    self!.songImage.image = image
                })
            })
            
            HRPlayerManager.sharedInstance.backgroundChanged.listen(self!, callback: { (image) -> Void in
                dispatch.async.main({ () -> Void in
                    self!.backgroundImage.image = image
                })
            })
            
            HRPlayerManager.sharedInstance.playSignal.listen(self!, callback: { (played) -> Void in
                dispatch.async.main({ () -> Void in

                    if played == true {
                        UIView.animateWithDuration(0.2) { () -> Void in
                            self!.pauseButton.alpha = 1.0
                            self!.playButton.alpha = 0.0
                            self!.playButton.enabled = false
                            self!.pauseButton.enabled = true
                        }
                    } else {
                        UIView.animateWithDuration(0.2) { () -> Void in
                            self!.pauseButton.alpha = 0.0
                            self!.playButton.alpha = 1.0
                            self!.playButton.enabled = true
                            self!.pauseButton.enabled = false
                        }
                    }
                })
            })
            
        }

    }
    
    
    func seekToSliderValue() {
        
        let song = HRPlayerManager.sharedInstance.currentItem
        
        let second = Int(Float(self.songSlider.value) * Float(song.duration))
        
        HRPlayerManager.sharedInstance.queue.queuePlayer.playAtSecond(second)
        
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
    
    // actions
    
    func actionBroadcast() {
        HRPlayerManager.sharedInstance.actionBroadcast()
        if HRPlayerManager.sharedInstance.broadcastState == true {
            self.broadcastButton.setImage(UIImage(named: "stream")?.imageWithColor(UIColor.redColor()), forState: UIControlState.Normal)
        } else {
            self.broadcastButton.setImage(UIImage(named: "stream")?.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Normal)
        }
    }
    
    func actionAdd() {
        HRPlayerManager.sharedInstance.actionAddCurrentSong()
        self.addButton.enabled = false
    }
    
    func adtionShuffle() {
        HRPlayerManager.sharedInstance.actionShuffle()
        if HRPlayerManager.sharedInstance.shuffleState == true {
            self.shuffleButton.setImage(UIImage(named: "shuffle")?.imageWithColor(UIColor.redColor()), forState: UIControlState.Normal)
        } else {
            self.shuffleButton.setImage(UIImage(named: "shuffle")?.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Normal)
        }
    }
    
    func actionRepeat() {
        HRPlayerManager.sharedInstance.actionRepeat()
        if HRPlayerManager.sharedInstance.repeatState == true {
            self.repeatButton.setImage(UIImage(named: "repeatOne")?.imageWithColor(UIColor.redColor()), forState: UIControlState.Normal)
        } else {
            self.repeatButton.setImage(UIImage(named: "refresh")?.imageWithColor(UIColor.whiteColor()), forState: UIControlState.Normal)
        }
    }
    
    func closeAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
