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


class HRInterfaceManager: NSObject  {

    static let sharedInstance = HRInterfaceManager()
    
    var drawerController: DrawerController!
    
    var mainNav: HRNavigationController!
    
    var authController = AuthController()
    
    var musicNav : HRNavigationController!
    var downloadsNav : HRNavigationController!
    var settingsNav : HRNavigationController!
    var albumsNav : HRNavigationController!
    
    
    var currentAudioOpenID = 0
    
    var menuOppened = false
    
    required override init() {
        super.init()
        
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
        
        self.drawerController.drawerVisualStateBlock = { (drawerController, drawerSide, percentVisible) in
            _ = DrawerVisualState.swingingDoorVisualStateBlock
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.mainNav.pushViewController(self.drawerController, animated: false)
        }
        
        
    }
    
    func openMenu() {
        
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true, completion: nil)
        
    }
    
    func openMusicList() {
        
        self.musicNav = HRNavigationController(rootViewController: AllMusicController())
        self.settingsNav = nil
        self.albumsNav = nil
        self.downloadsNav = nil
        
        self.drawerController.setCenterViewController(self.musicNav!, withCloseAnimation: false, completion: nil)
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true) { (finish) -> Void in
            if finish == true {
                
            }
        }
    
    }
    
    func openDownloads() {
        
        self.musicNav = nil
        self.settingsNav = nil
        self.albumsNav = nil
        self.downloadsNav = HRNavigationController(rootViewController: DownloadsController())
        
        self.drawerController.setCenterViewController(self.downloadsNav!, withCloseAnimation: false, completion: nil)
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true) { (finish) -> Void in
            if finish == true {
                
            }
        }
        
    }
    
    func openAlbums() {
        
        self.musicNav = nil
        self.settingsNav = nil
        self.albumsNav = HRNavigationController(rootViewController: HRAlbumsController())
        self.downloadsNav = nil
        
        self.drawerController.setCenterViewController(self.albumsNav!, withCloseAnimation: false, completion: nil)
        self.drawerController.toggleDrawerSide(DrawerSide.Left, animated: true) { (finish) -> Void in
            if finish == true {
                
            }
        }
        
    }
    
    func openSettings() {
        
        self.musicNav = nil
        self.settingsNav = HRNavigationController(rootViewController: SettingsController())
        self.albumsNav = nil
        self.downloadsNav = nil
        
        self.drawerController.setCenterViewController(self.settingsNav!, withCloseAnimation: false, completion: nil)
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

}
