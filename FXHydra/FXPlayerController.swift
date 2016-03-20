//
//  FXPlayerController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/18/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit
import YYKit

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
    
    var addToDownloadButton : UIButton!
    var prevSongButton      : UIButton!
    var playPauseButton     : UIButton!
    var nextSongButton      : UIButton!
    var playlistButton      : UIButton!
    
    var volumeSlider        : UISlider!
    var volumeLeftImage     : UIImageView!
    var volumeRightImage    : UIImageView!
    
    // tool bar
    
    var toolBar : UIToolbar!
    
    // height 190
    
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
        
        ///////////////////////////////////////////////////////////////
        
        self.controllersContainer = UIView()
        self.controllersContainer.backgroundColor = UIColor.clearColor()
        
        //
        
        self.songSlider         = UISlider()
        
        /*
        self.songSlider.addTarget(self, action: "seekToSliderValue", forControlEvents: UIControlEvents.ValueChanged)
        */
        
        let globalTintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let trackLeftImage1 = UIImage(named: "min_slider_image")!.imageByTintColor(globalTintColor)
        let trackLeftResizable1 = trackLeftImage1!.resizableImageWithCapInsets(insets)
        self.songSlider.setMinimumTrackImage(trackLeftResizable1, forState: UIControlState.Normal)
        
        let trackRightImage1 = UIImage(named: "max_slider_image")!
        let trackRightResizable1 = trackRightImage1.resizableImageWithCapInsets(insets)
        self.songSlider.setMaximumTrackImage(trackRightResizable1, forState: UIControlState.Normal)
        
        self.songSlider.setThumbImage(UIImage(named: "track_slider_tumb")!.imageByTintColor(globalTintColor), forState: UIControlState.Normal)
        
        ///
        
        self.songTimeLeftLabel  = AttributedLabel()
        self.songTimeRightLabel = AttributedLabel()
        
        self.songTitleLabel     = MarqueeLabel()
        self.songArtistLabel    = AttributedLabel()
        
        self.addToDownloadButton    = UIButton(type: UIButtonType.System)
        self.prevSongButton         = UIButton(type: UIButtonType.System)
        self.nextSongButton         = UIButton(type: UIButtonType.System)
        self.playPauseButton        = UIButton(type: UIButtonType.System)
        self.playlistButton         = UIButton(type: UIButtonType.System)
        
        self.volumeSlider = UISlider()
        
        let volumeLeftImage1 = UIImage(named: "min_slider_image")!.imageByTintColor(globalTintColor)
        let volumeLeftResizable1 = volumeLeftImage1!.resizableImageWithCapInsets(insets)
        self.volumeSlider.setMinimumTrackImage(volumeLeftResizable1, forState: UIControlState.Normal)
        
        let volumeRightImage1 = UIImage(named: "max_slider_image")!
        let volumeRightResizable1 = volumeRightImage1.resizableImageWithCapInsets(insets)
        self.volumeSlider.setMaximumTrackImage(volumeRightResizable1, forState: UIControlState.Normal)
        
        self.volumeSlider.setThumbImage(UIImage(named: "volume_slider_tumb")!.imageByTintColor(globalTintColor), forState: UIControlState.Normal)
        
        self.volumeLeftImage = UIImageView()
        self.volumeLeftImage.image = UIImage(named: "volume_down")?.imageByTintColor(UIColor.lightGrayColor())
        
        
        self.volumeRightImage = UIImageView()
        self.volumeRightImage.image = UIImage(named: "volume_up")?.imageByTintColor(UIColor.lightGrayColor())
        
        ///
        
        self.toolBar = UIToolbar()
        
        
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
        self.controllersContainer.addSubview(self.playlistButton)
        
        // volume changes :)
        self.controllersContainer.addSubview(self.volumeSlider)
        self.controllersContainer.addSubview(self.volumeLeftImage)
        self.controllersContainer.addSubview(self.volumeRightImage)
        
        /// toolbar
        
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
        self.loadAudioStateInfo()
        self.loadToolBar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let viewSize = self.view.frame.size
        
        // background
        
        self.backgroundImage.frame = self.view.frame
        self.blurEffectView.frame = self.view.frame
        
        // containers
        
        self.controllersContainer.frame = CGRectMake(0, viewSize.height-190-44, viewSize.width, 190)
        
        let songCoverTop = (self.navigationController?.navigationBar.bottom)!
        let songCoverHeight = self.controllersContainer.top - songCoverTop
        
        self.songCoverContainer.frame = CGRectMake(0, (self.navigationController?.navigationBar.bottom)!, viewSize.width, songCoverHeight)
        
        // cover
        
        let songContainterSize = self.songCoverContainer.frame.size
        let coverSize = songContainterSize.height - 15
        
        self.songCoverImage.frame = CGRectMake(songContainterSize.width/2-coverSize/2, songContainterSize.height/2-coverSize/2, coverSize, coverSize)
        
        // controllers
        
        let contSize = self.controllersContainer.frame.size
        
        self.songSlider.frame = CGRectMake(10, 0, contSize.width-20, 20)
        
        
        self.volumeSlider.frame =  CGRectMake(40, contSize.height-30, contSize.width-80, 20)
        self.volumeLeftImage.frame = CGRectMake(15, self.volumeSlider.centerY-5, 10, 10)
        self.volumeRightImage.frame = CGRectMake(contSize.width-25, self.volumeSlider.centerY-5, 10, 10)
        
        
        self.toolBar.frame = CGRectMake(0, viewSize.height-44, viewSize.width, 44)
        
    }
    
    // MARK - Load audio state 
    
    func loadContent() {
        
        self.backgroundImage.image = UIImage(named: "player_background_default")
        self.songCoverImage.image = UIImage(named: "player_background_default")
        
        // placeholders
        
        
        
    }
    
    func loadAudioStateInfo() {
        
        self.title = "1 of 54"
        
    }
    
    func loadToolBar() {
        
        // style
        
        self.toolBar.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        //self.toolBar.setShadowImage(UIImage().imageByTintColor(UIColor.whiteColor()), forToolbarPosition: UIBarPosition.Any)
        self.toolBar.translucent = true
        self.toolBar.backgroundColor = UIColor.clearColor()
        self.toolBar.tintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        
        // items
        
        var items = [UIBarButtonItem]()
        
        //
        
        let flexSpaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let equalizer = UIBarButtonItem(image: UIImage(named: "toolbar_equalizer"), style: UIBarButtonItemStyle.Plain, target: self, action: "openEqualizer")
        
        let flexSpaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        //
        
        items.append(flexSpaceLeft)
        items.append(equalizer)
        items.append(flexSpaceRight)
        
        self.toolBar.setItems(items, animated: false)
        
    }
    
    // MARK - UI Customized
    
    func loadNavButtons() {
        
        let closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeControllerAction")
        self.navigationItem.leftBarButtonItem = closeButton
        
        ///
        
        let actionsButton = UIBarButtonItem(title: "Actions", style: UIBarButtonItemStyle.Plain, target: self, action: "navButtonActionsAction")
        self.navigationItem.rightBarButtonItem = actionsButton
        
    }
    
    // MARK - Actions
    
    func closeControllerAction() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func navButtonActionsAction() {
        
        log.debug("::: navButtonActionsAction :::")
        
    }
    
    func openEqualizer() {
        
        log.debug("::: openEqualizer :::")
        
    }
    

}
