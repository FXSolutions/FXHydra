import UIKit
import XCGLogger

let log = XCGLogger.defaultInstance()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var documentsDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex-1] as NSURL
    }
    
    var cacheDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex-1] as NSURL
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = UIColor.clearColor()
        window.rootViewController = HRInterfaceManager.sharedInstance.authController
        window.makeKeyAndVisible()
        self.window = window
        
        HRDatabaseManager.sharedInstance
        
        let logPath : NSURL = self.cacheDirectory.URLByAppendingPathComponent("XCGLogger_Log.txt")
        log.setup(.Debug, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath, fileLogLevel: .Debug)
        
        
        // yandex.metrica
        
        YMMYandexMetrica.activateWithApiKey("47597ab5-08d4-403f-b027-cf0d10b3c54d")
        YMMYandexMetrica.setReportCrashesEnabled(true)
        YMMYandexMetrica.setVersion(<#T##aVersion: Int##Int#>)
        

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        VKSdk.processOpenURL(url, fromApplication: sourceApplication)
        return true
    }
    
    override func remoteControlReceivedWithEvent(event: UIEvent?) {
        
        if event?.type == UIEventType.RemoteControl {
            
            switch (event!.subtype) {
                
            case UIEventSubtype.RemoteControlPlay:
                HRPlayerManager.sharedInstance.playCurrent()
                break
                
            case UIEventSubtype.RemoteControlPause:
                HRPlayerManager.sharedInstance.pause()
                break
                
            case UIEventSubtype.RemoteControlNextTrack:
                HRPlayerManager.sharedInstance.playNext()
                break
                
            case UIEventSubtype.RemoteControlPreviousTrack:
                HRPlayerManager.sharedInstance.playPrev()
                break
            case UIEventSubtype.RemoteControlTogglePlayPause:
                if HRPlayerManager.sharedInstance.queue.queuePlayer.status == AFSoundStatus.Paused {
                    HRPlayerManager.sharedInstance.playCurrent()
                } else {
                    HRPlayerManager.sharedInstance.pause()
                }
                
            default:
                log.debug("kek :D")
                break
                
            }
            
        }
        
    }

}

