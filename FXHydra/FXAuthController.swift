//
//  FXAuthController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXAuthController: VideoSplashViewController {
    
    var loginButton : UIButton!
    var logoView : UIImageView!
    
    override func loadView() {
        super.loadView()
        
        self.loginButton = UIButton(type: .System)
        self.loginButton.setTitle("Authorization", forState: UIControlState.Normal)
        self.loginButton.addTarget(self, action: "authButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.loginButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 17)
        self.loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.loginButton.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.7)
        self.loginButton.layer.cornerRadius = 5.0
        self.loginButton.layer.zPosition = 1000
        
        
        ////
        
        self.logoView = UIImageView()
        self.logoView.image = UIImage(named: "auth_logo")
        self.logoView.alpha = 0.8
        
        
        self.view.addSubview(self.logoView)
        self.view.addSubview(self.loginButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let viewSize = self.view.frame.size
        
        self.loginButton.frame = CGRectMake(viewSize.width/2-100, viewSize.height-80, 200, 50)
        self.logoView.frame = CGRectMake(viewSize.width/2-75, 60,150, 150)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoBackground()
        
        
        FXSignalsService.sharedManager().appChangeStateToBackground.listen(self) { (isBackground) -> Void in
            
            if (isBackground == true) {
                self.moviePlayer.player?.pause()
            } else {
                self.moviePlayer.player?.play()
            }
            
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func setupVideoBackground() {
        
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("moments", ofType: "mp4")!)
        
        videoFrame = view.frame
        fillMode = .ResizeAspectFill
        alwaysRepeat = true
        sound = false
        startTime = 2.0
        alpha = 0.8
        
        contentURL = url
        view.userInteractionEnabled = false
        
    }
    
    ////////
    
    func authButtonAction() {
        
        log.debug("it works!")
        
    }
    
    func authButtonTuchIt() {
        
        log.debug("authButtonTuchIt")
        
    }

    
    

}
