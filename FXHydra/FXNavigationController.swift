//
//  FXNavigationController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/18/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.tintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        self.navigationBar.barTintColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
        self.navigationItem.titleView?.tintColor = UIColor.whiteColor()
        
        self.interactivePopGestureRecognizer!.enabled = true
        self.navigationBar.translucent = false
        
        
        let titleDict = [NSFontAttributeName : UIFont(name: "Avenir-Book", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.navigationBar.titleTextAttributes = titleDict
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
