import UIKit

class ZAlert: NSObject {
    var actions = Array<UIAlertAction>()
    var title:String
    var message:String
    var style:UIAlertControllerStyle
    
    class func alert(title:String?,message:String?) -> ZAlert! {
        return ZAlert(title: title, message: message, style: .Alert)
    }
    class func actionSheet(title:String?,message:String?) -> ZAlert! {
        return ZAlert(title: title, message: message, style: .ActionSheet)
    }
    init(title:String?,message:String?,style:UIAlertControllerStyle) {
        self.title = title!
        self.message = message!
        self.style = style
    }
    func action(title:String,style:UIAlertActionStyle,handler:(action:UIAlertAction!) -> ()) -> ZAlert! {
        let alertAction = UIAlertAction(title: title, style: style, handler: handler)
        self.actions.append(alertAction)
        return self;
    }
    func present(inViewConftoller:UIViewController!,animated:Bool,completion: (() -> Void)?) -> Void {
        let alert = UIAlertController(title: self.title, message: self.message, preferredStyle: self.style)
        for action in self.actions {
            alert.addAction(action)
        }
        inViewConftoller.presentViewController(alert, animated: animated, completion: completion)
    }
}