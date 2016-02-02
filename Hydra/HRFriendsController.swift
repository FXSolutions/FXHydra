//
//  HRFriendsMusicController.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/22/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit
import Nuke
import VK_ios_sdk
import YYKit

class HRFriendsController: UITableViewController {
    
    var friendsArray = Array<HRFriendModel>()
    var loading = false
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Friends"
        
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.loadFriends()
        
        self.tableView.registerClass(HRFriendsCell.self, forCellReuseIdentifier: "HRFriendsCell")
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        self.addLeftBarButton()
        
        
//        YYImageCache *cache = [YYWebImageManager sharedManager].cache;
//        
//        // get cache capacity
//        cache.memoryCache.totalCost;
//        cache.memoryCache.totalCount;
//        cache.diskCache.totalCost;
//        cache.diskCache.totalCount;
//        
//        // clear cache
//        [cache.memoryCache removeAllObjects];
//        [cache.diskCache removeAllObjects];
        
        let cache = YYWebImageManager.sharedManager().cache
        
        cache.memoryCache.removeAllObjects()
        cache.diskCache.removeAllObjects()

        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    
    // MARK: - load all audio
    
    
    func loadFriends() {
        
        if loading == false {
            loading = true
            
            let getFriends = VKRequest(method: "friends.get", parameters: ["order":"hints","count":100,"offset":self.friendsArray.count,"fields":"photo_100,can_see_audio","name_case":"nom"])
            
            getFriends.executeWithResultBlock({ (response) -> Void in
                
                let json = response.json as! Dictionary<String,AnyObject>
                let items = json["items"] as! Array<Dictionary<String,AnyObject>>
                
                
                for friendDict in items {

                    print(friendDict)

                    let jsonFriendItem = JSON(friendDict)
                    let friendItemModel = HRFriendModel(json: jsonFriendItem)

                    self.friendsArray.append(friendItemModel)

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
        return self.friendsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell:HRFriendsCell = self.tableView.dequeueReusableCellWithIdentifier("HRFriendsCell", forIndexPath: indexPath) as! HRFriendsCell
        
        
        let friend = self.friendsArray[indexPath.row]
        
        cell.friendName.text = "\(friend.first_name!) \(friend.last_name!)"
        
        cell.friendAvatar.setImageWithURL(NSURL(string: friend.photo_100), options: YYWebImageOptions.Progressive.union(YYWebImageOptions.SetImageWithFadeAnimation).union(YYWebImageOptions.IgnoreDiskCache).union(YYWebImageOptions.RefreshImageCache))
        
        //RefreshImageCache
        
        cell.friendAvatar.setImageWithURL(NSURL(string: friend.photo_100), placeholder: nil, options: YYWebImageOptions.Progressive.union(YYWebImageOptions.SetImageWithFadeAnimation), progress: { (_, _) -> Void in
            // progress
            }, transform: { (image, nsurl) -> UIImage! in
                return image.imageByRoundCornerRadius(image.size.height)
            }) { (image, url, fromType, ImageStage, error) -> Void in
                // complite
        }
        
        
        if friend.can_see_audio == false {
            cell.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.1)
            cell.accessImage.image = UIImage(named: "access_denied")
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let friend = self.friendsArray[indexPath.row]
        
        if friend.can_see_audio == true {
            
            let friendAudioController = HRFriendAudioController()
            friendAudioController.friendModel = friend
            friendAudioController.title = "\(friend.first_name!) \(friend.last_name!)"
            
            self.navigationController?.pushViewController(friendAudioController, animated: true)
            
        } else {
            self.showAccessDeniedAlert()
        }
        
        
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
        
        
        if indexPath.row == self.friendsArray.count - 7 {
            self.loadFriends()
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
    
    func showAccessDeniedAlert() {
        
        let alertController = UIAlertController(title: "Access denied", message: "User blocked audio", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            //
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

}
