//
//  HRSettingsController.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/21/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit

class HRSettingsController: UIViewController {
    
    var logOutButton : UIButton!
    
    override func loadView() {
        super.loadView()
        
        self.logOutButton = UIButton(type: UIButtonType.System)
        self.logOutButton.addTarget(self, action: "logOut", forControlEvents: UIControlEvents.TouchUpInside)
        self.logOutButton.backgroundColor = UIColor.redColor()
        self.logOutButton.setTitle("LOG OUT", forState: UIControlState.Normal)
        self.logOutButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.view.addSubview(self.logOutButton)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.addLeftBarButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.logOutButton.frame = CGRectMake(screenSizeWidth/2-60, 70, 120, 50)
    }
    
    func addLeftBarButton() {
        
        let button = UIBarButtonItem(image: UIImage(named: "menuHumb"), style: UIBarButtonItemStyle.Plain, target: self, action: "openMenu")
        self.navigationItem.leftBarButtonItem = button
        
    }
    
    func openMenu() {
        
        HRInterfaceManager.sharedInstance.openMenu()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    func logOut() {
        
        VKSdk.forceLogout()
        
        
    }
    

}
