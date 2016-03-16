//
//  FXTabBarController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/12/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        self.tabBar.barTintColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
        self.tabBar.translucent = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        for tab in self.viewControllers! {
            tab.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont(name: "Avenir-Book", size: 10)!], forState: UIControlState.Normal)
        }
        
    }
    
    func updateTitles() {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
