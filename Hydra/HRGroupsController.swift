//
//  HRGroupsController.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/22/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit
import Nuke
import VK_ios_sdk

class HRGroupsController: UITableViewController {

    var groupsArray = Array<HRGroupModel>()
    var loading = false
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Groups"
        
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.loadGroups()
        
        self.tableView.registerClass(HRGroupCell.self, forCellReuseIdentifier: "HRGroupCell")
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        self.addLeftBarButton()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    
    // MARK: - load all audio
    
    
    func loadGroups() {
        
        if loading == false {
            loading = true
            
            let getGroups = VKRequest(method: "groups.get", andParameters: ["extended":1,"fields":"counters,photo_100,photo_200","offset":self.groupsArray.count])
            
            getGroups.executeWithResultBlock({ (response) -> Void in
                

                
                let json = response.json as! Dictionary<String,AnyObject>
                let items = json["items"] as! Array<Dictionary<String,AnyObject>>
                
                
                for groupDict in items {
                    
                    let jsonGroupItem = JSON(groupDict)
                    let groupItemModel = HRGroupModel(json: jsonGroupItem)
                    
                    self.groupsArray.append(groupItemModel)
                    
                }
                
                self.tableView.reloadData()
                self.loading = false
                
                }, errorBlock: { (error) -> Void in
                    
                    log.error("error loading friends")
                    
            })
            
        }
        
    }
    
    // mark: - tableView delegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let group = self.groupsArray[indexPath.row]
        
        let cell:HRGroupCell = self.tableView.dequeueReusableCellWithIdentifier("HRGroupCell", forIndexPath: indexPath) as! HRGroupCell
        
        
        cell.groupName.text = group.name
        
        var request = ImageRequest(URL: NSURL(string: group.photo_200)!)
        request.targetSize = CGSizeMake(cell.groupAvatar.frame.width*screenScaleFactor, cell.groupAvatar.frame.height*screenScaleFactor)
        request.contentMode = .AspectFill

        Nuke.taskWithRequest(request) {
            let imagekek = $0.image // Image is resized
            cell.groupAvatar.image = imagekek?.roundImage()
            
            }.resume()
        
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let group = self.groupsArray[indexPath.row]
        
        let groupAudioController = HRGroupAudioController()
        groupAudioController.groupModel = group
        groupAudioController.title = "\(group.name)"
        
        
        self.navigationController?.pushViewController(groupAudioController, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            //add code here for when you hit delete
        }
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == self.groupsArray.count - 3 {
            self.loadGroups()
        }
        
    }
    
    //MARK :- stuff
    
    
    func addLeftBarButton() {
        
        
        let button = UIBarButtonItem(image: UIImage(named: "menuHumb"), style: UIBarButtonItemStyle.Plain, target: self, action: "openMenu")
        self.navigationItem.leftBarButtonItem = button
        
    }
    
    func openMenu() {
        
        HRInterfaceManager.sharedInstance.openMenu()
        
    }

}
