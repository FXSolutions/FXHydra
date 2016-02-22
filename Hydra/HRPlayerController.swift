//
//  HRPlayerController.swift
//  Hydra
//
//  Created by kioshimafx on 2/22/16.
//  Copyright © 2016 kioshimafx. All rights reserved.
//

import UIKit

class HRPlayerController: UIViewController {
    
    // title
    var closeButton : UIButton!
    
    var songsCountLabel : UILabel!
    
    var actionsButton : UIButton!
    
    
    var songTitleLabel: MarqueeLabel!
    var songArtistLabel: UILabel!
    
    // song cover
    var coverView : UIView!
    var lyricsText : UITextView!
    var showingLyrics : Bool!
    
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
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
