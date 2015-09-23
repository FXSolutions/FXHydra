//
//  HRGroupCell.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/22/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit

class HRGroupCell: UITableViewCell {
    
    var groupName : AttributedLabel
    var groupAvatar : UIImageView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.groupName = AttributedLabel()
        self.groupName.font = UIFont(name: "HelveticaNeue-Light", size: 17)!
        self.groupName.textColor = UIColor.blackColor()
        self.groupName.backgroundColor = UIColor.whiteColor()
        
        self.groupAvatar = UIImageView()
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.groupName)
        self.contentView.addSubview(self.groupAvatar)
        
        self.separatorInset = UIEdgeInsetsMake(0, 70, 0, 0)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.groupName.frame = CGRectMake(70, 20, screenSizeWidth-70, 30)
        self.groupAvatar.frame = CGRectMake(10, 10, 50, 50)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.backgroundColor = UIColor.whiteColor()
        self.groupAvatar.image = nil
    }

}
