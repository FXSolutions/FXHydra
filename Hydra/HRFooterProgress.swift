//
//  HRFooterProgress.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/22/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit

class HRFooterProgress: UIView {
    
    var progressActivity : UIActivityIndicatorView!
    var infoTitle : UILabel!
    
    override init(frame: CGRect) {
        let customFrame = CGRectMake(0, 0, screenSizeWidth, 80)
        super.init(frame: customFrame)
        
        self.progressActivity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.progressActivity.frame = CGRectMake(screenSizeWidth/2-5, 60, 10, 10)
        
        self.infoTitle = UILabel()
        self.infoTitle.frame = CGRectMake(0, 5, screenSizeWidth, 50)
        self.infoTitle.textColor = UIColor.grayColor()
        self.infoTitle.font = UIFont(name: "Avenir-Book", size: 17)
        self.infoTitle.textAlignment = NSTextAlignment.Center
        self.infoTitle.numberOfLines = 0
        
        self.addSubview(self.progressActivity)
        self.addSubview(self.infoTitle)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startProgress() {
        self.progressActivity.startAnimating()
    }
    
    func stopProgress() {
        self.progressActivity.stopAnimating()
        self.hideTitle()
    }
    
    func titleText(text:String) {
        self.infoTitle.text = text
        self.showTitle()
    }
    
    func showTitle() {
        self.infoTitle.hidden = false
    }
    
    func hideTitle() {
        self.infoTitle.hidden = true
    }


}
