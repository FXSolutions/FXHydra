//
//  HRSettingsController.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/21/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit

class HRSettingsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        
        self.addLeftBarButton()
    }
    
    func addLeftBarButton() {
        
        let button = UIBarButtonItem(image: UIImage(named: "menuHumb"), style: UIBarButtonItemStyle.Plain, target: self, action: "openMenu")
        self.navigationItem.leftBarButtonItem = button
        
    }
    
    func openMenu() {
        
        HRInterfaceManager.sharedInstance.openMenu()
        
    }
    

}
