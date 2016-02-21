//
//  SettingsController.swift
//  Hydra
//
//  Created by Evgeny Abramov on 7/1/15.
//  Copyright (c) 2015 Evgeny Abramov. All rights reserved.
//

import UIKit
import VK_ios_sdk

class SettingsController: UITableViewController {
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        
        self.addLeftBarButton()
        
        self.tableView.registerClass(HRTitleSettingsCell.self, forCellReuseIdentifier: "HRTitleSettingsCell")
        self.tableView.rowHeight = 60
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.allowsMultipleSelectionDuringEditing = false
        self.tableView.indicatorStyle = UIScrollViewIndicatorStyle.White
        self.tableView.backgroundColor = UIColor ( red: 0.2228, green: 0.2228, blue: 0.2228, alpha: 1.0 )
        self.tableView.separatorColor = UIColor ( red: 0.2055, green: 0.2015, blue: 0.2096, alpha: 1.0 )
        
        self.view.backgroundColor = UIColor ( red: 0.1221, green: 0.1215, blue: 0.1227, alpha: 1.0 )
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    func addLeftBarButton() {
        
        let button = UIBarButtonItem(image: UIImage(named: "menuHumb"), style: UIBarButtonItemStyle.Plain, target: self, action: "openMenu")
        self.navigationItem.leftBarButtonItem = button
        
    }
    
    func openMenu() {
        
        HRInterfaceManager.sharedInstance.openMenu()
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:HRTitleSettingsCell = tableView.dequeueReusableCellWithIdentifier("HRTitleSettingsCell") as! HRTitleSettingsCell
        cell.mainTitle.text = "LOG OUT"
        cell.mainTitle.textColor = UIColor.redColor()
        cell.mainTitle.contentAlignment = .Center
        cell.backgroundColor = UIColor ( red: 0.1555, green: 0.154, blue: 0.157, alpha: 1.0 )
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.logOut()
        
    }
    
    
    func logOut() {
        
        VKSdk.forceLogout()
        HRInterfaceManager.sharedInstance.logOut()
        
    }
    
}
