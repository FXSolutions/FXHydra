
import UIKit
import VK_ios_sdk

class AuthController: UIViewController,VKSdkDelegate {

    var motionView:UIImageView!
    var authButton: UIButton!
    var authLogo:UIImageView!
    
    override func loadView() {
        super.loadView()
        
        VKSdk.initializeWithDelegate(self, andAppId: "4689635")
        if VKSdk.wakeUpSession() == true {
            self.startWorking()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.motionView = UIImageView(frame: CGRectMake(0, 0, screenSizeWidth, screenSizeHeight))
        self.motionView.image = UIImage(named: "placeholderBackground")
        
        self.view.addSubview(self.motionView)
        
        self.motionView.frame = CGRectMake(0, 0, screenSizeWidth, screenSizeHeight)
        
        self.authButton = UIButton(frame: CGRectMake(screenSizeWidth/2 - 100, screenSizeHeight-150, 200, 50))
        self.authButton.setTitle("Авторизация", forState: UIControlState.Normal)
        self.authButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.authButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        self.authButton.setBackgroundImage(UIImage(named: "authButton"), forState: UIControlState.Normal)
        self.authButton.addTarget(self, action: "authButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.authButton)
        
        self.authLogo = UIImageView(frame: CGRectMake(screenSizeWidth/2 - 100, 100, 200, 200))
        self.authLogo.image = UIImage(named: "authLogo")
        self.view.addSubview(self.authLogo)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func authButtonAction() {
        log.debug("auth button action")
        
        
        VKSdk.authorize(["audio","status","groups"], revokeAccess: true)
    }
    
    func startWorking() {
        
        dispatch.async.main { () -> Void in
            
            HRInterfaceManager.sharedInstance.openDrawer()
            
            self.presentViewController(HRInterfaceManager.sharedInstance.mainNav, animated: false, completion: nil)
        }
        
    }
    
    func vkSdkNeedCaptchaEnter(captchaError: VKError!) {
        //
    }
    
    func vkSdkTokenHasExpired(expiredToken: VKAccessToken!) {
        //
    }
    
    func vkSdkReceivedNewToken(newToken: VKAccessToken!) {
        self.startWorking()
    }
    
    func vkSdkShouldPresentViewController(controller: UIViewController!) {
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func vkSdkAcceptedUserToken(token: VKAccessToken!) {
        self.startWorking()
    }
    
    func vkSdkUserDeniedAccess(authorizationError: VKError!) {
        //
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
