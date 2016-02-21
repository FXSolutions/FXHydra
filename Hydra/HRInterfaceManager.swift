//
//  HRInterfaceManager.swift
//  Hydra
//
//  Created by Evgeny Abramov on 7/1/15.
//  Copyright (c) 2015 Evgeny Abramov. All rights reserved.
//

import Foundation

enum DrawerAnimationType: Int {
    case None
    case Slide
    case SlideAndScale
    case SwingingDoor
    case Parallax
    case AnimatedBarButton
}

enum HRCurrentOpenNav: Int {
    case HRAllMusicOpen
    case HRDownloadsOpen
    case HRSettingsOpen
}


class HRInterfaceManager  {

    static let sharedInstance = HRInterfaceManager()
    
    var drawerController: DrawerController!
    
    var mainNav: HRNavigationController!
    
    var authController = AuthController()

    var currentAudioOpenID = 0
    
    var menuOppened = false
    
    
    init() {
        self.mainNav = HRNavigationController()
        self.mainNav.navigationBarHidden = true
    }
    
    
    func openDrawer() {
        
        let audioNav = HRNavigationController(rootViewController: AllMusicController())
        let menuNav = HRNavigationController(rootViewController: MenuController())
        menuNav.navigationBarHidden = true
        
        self.drawerController = DrawerController(centerViewController: audioNav, leftDrawerViewController: menuNav)
        
        self.drawerController.showsShadows = false
        self.drawerController.restorationIdentifier = "Drawer"
        self.drawerController.maximumRightDrawerWidth = 200.0
        self.drawerController.openDrawerGestureModeMask = .PanningCenterView
        self.drawerController.closeDrawerGestureModeMask = .All
        self.drawerController.shouldStretchDrawer = false
        self.drawerController.maximumLeftDrawerWidth = screenSizeWidth-60
        
        
        HRDataManager.sharedInstance.getAllDownloadedIdsFromDb { (done) -> () in
            
            dispatch.async.main { () -> Void in
                self.mainNav.pushViewController(self.drawerController, animated: false)
            }
            
        }
        
    }
    
    func openMenu() {
        
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true, completion: nil)
        
    }
    
    func openMusicList() {
        
        let musicNav = HRNavigationController(rootViewController: AllMusicController())
        
        self.drawerController.setCenterViewController(musicNav, withCloseAnimation: false, completion: nil)
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true) { (finish) -> Void in
            if finish == true {
                
            }
        }
    
    }
    
    func openDownloads() {
        
        let downloadsNav = HRNavigationController(rootViewController: DownloadsController())
        
        self.drawerController.setCenterViewController(downloadsNav, withCloseAnimation: false, completion: nil)
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true) { (finish) -> Void in
            if finish == true {
                
            }
        }
        
    }
    
    func openGroups() {
        
        let groupsNav  = HRNavigationController(rootViewController: HRGroupsController())
        
        self.drawerController.setCenterViewController(groupsNav, withCloseAnimation: false, completion: nil)
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true) { (finish) -> Void in
            if finish == true {
                
            }
        }
        
    }
    
    func openAlbums() {
        
        let albumsNav = HRNavigationController(rootViewController: HRPlaylistsController())
        
        self.drawerController.setCenterViewController(albumsNav, withCloseAnimation: false, completion: nil)
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true) { (finish) -> Void in
            if finish == true {
                
            }
        }
        
    }
    
    func openFriends() {
        
        let friendsNav = HRNavigationController(rootViewController: HRFriendsController())
        
        self.drawerController.setCenterViewController(friendsNav, withCloseAnimation: false, completion: nil)
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true) { (finish) -> Void in
            if finish == true {
                
            }
        }
        
    }
    
    func openSettings() {
        
        let settingsController = SettingsController(style : .Grouped)
        let settingsNav = HRNavigationController(rootViewController: settingsController)
        
        self.drawerController.setCenterViewController(settingsNav, withCloseAnimation: false, completion: nil)
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true) { (finish) -> Void in
            if finish == true {
                
            }
        }
        
    }
    
    func closeMenu() {
        
        if self.drawerController.openSide == DrawerSide.Left {
            self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: false, completion: nil)
        }
        
    }
    
    func logOut() {
        
        self.mainNav.dismissViewControllerAnimated(false) { () -> Void in
            //
            
            
        
        }
        
    }
    
    func openPlayer() {
        
        
        self.drawerController.presentViewController(PlayerController(), animated: true, completion: nil)
        
        
    }

}
