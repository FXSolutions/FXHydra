//
//  HRNavigationController.swift
//  Hydra
//
//  Created by Evgeny Abramov on 7/1/15.
//  Copyright (c) 2015 Evgeny Abramov. All rights reserved.
//

import UIKit

class HRNavigationController: BufferedNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.barTintColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
        
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        
        self.interactivePopGestureRecognizer!.enabled = true
        
        self.navigationBar.translucent = false
        
        let titleDict = [NSFontAttributeName : UIFont(name: "Avenir-Book", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.navigationBar.titleTextAttributes = titleDict
        
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}


extension UISearchController { public override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent } }