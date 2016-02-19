//
//  HRTitleSettingsCell.swift
//  Hydra
//
//  Created by kioshimafx on 2/19/16.
//  Copyright © 2016 kioshimafx. All rights reserved.
//

import UIKit

class HRTitleSettingsCell: UITableViewCell {

    var mainTitle : AttributedLabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.mainTitle = AttributedLabel()
        self.mainTitle.font = UIFont(name: "Avenir-Medium", size: 17)!
        self.mainTitle.textColor = UIColor.whiteColor()
        self.mainTitle.backgroundColor = UIColor.clearColor()
        self.mainTitle.contentAlignment = .Center
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.mainTitle)
        
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        self.contentView.backgroundColor = UIColor.clearColor()
        self.backgroundColor = UIColor.clearColor()
        
        
        let colorView = UIView()
        colorView.backgroundColor = UIColor ( red: 0.6037, green: 0.6037, blue: 0.6037, alpha: 0.195258620689655 )
        
        self.selectedBackgroundView = colorView
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainTitle.frame = CGRectMake(screenSizeWidth/2-70, 20, 140, 20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
}
