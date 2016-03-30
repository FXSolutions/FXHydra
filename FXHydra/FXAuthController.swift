//
//  FXAuthController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit
import VK_ios_sdk

class FXAuthController: VideoSplashViewController {
    
    var loginButton : UIButton!
    var logoView : UIImageView!
    
    override func loadView() {
        super.loadView()
        
        self.view.userInteractionEnabled = true
        
        self.loginButton = UIButton(type: .System)
        self.loginButton.setTitle("Authorization", forState: UIControlState.Normal)
        self.loginButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 17)
        self.loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.loginButton.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.7)
        self.loginButton.layer.cornerRadius = 5.0
        self.loginButton.addTarget(super.self(), action: #selector(FXAuthController.authButtonAction), forControlEvents:.TouchUpInside)
        self.loginButton.userInteractionEnabled = true
        
        
        ////
        
        self.logoView = UIImageView()
        self.logoView.image = UIImage(named: "auth_logo")
        self.logoView.alpha = 0.8
        
        
        self.view.addSubview(self.logoView)
        self.view.addSubview(self.loginButton)
        
        setupVideoBackground()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let viewSize = self.view.frame.size
        
        self.loginButton.frame = CGRectMake(viewSize.width/2-100, viewSize.height-100, 200, 50)
        self.logoView.frame = CGRectMake(viewSize.width/2-75, 60,150, 150)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ////
        
        
        
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
        
        self.loginButton.transform = CGAffineTransformMakeScale(0.6, 0.6)
        
        UIView.animateWithDuration(1.5,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.20),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.loginButton.transform = CGAffineTransformIdentity
            },
            completion: { Void in()  }
        )
        
        
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
        
    }
    
    ////////
    
    func authButtonAction() {
        
        log.debug("it works!")
        
        self.loginButton.transform = CGAffineTransformMakeScale(0.6, 0.6)
        
        UIView.animateWithDuration(1.0,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.20),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.loginButton.transform = CGAffineTransformIdentity
            },
            completion: { Void in()  }
        )
        
        log.debug("auth button action")
        
        VKSdk.authorize(["audio","status","groups"])
        
        
    }
    


}
