//
//  HRFriendsCell.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/22/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit

class HRFriendsCell: UITableViewCell {
    
    var friendName : AttributedLabel
    var friendAvatar : UIImageView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.friendName = AttributedLabel()
        self.friendName.font = UIFont(name: "HelveticaNeue-Light", size: 17)!
        self.friendName.textColor = UIColor.blackColor()
        self.friendName.backgroundColor = UIColor.clearColor()
        
        self.friendAvatar = UIImageView()
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.friendName)
        self.contentView.addSubview(self.friendAvatar)
        
        self.separatorInset = UIEdgeInsetsMake(0, 70, 0, 0)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.friendName.frame = CGRectMake(70, 20, screenSizeWidth-70, 30)
        self.friendAvatar.frame = CGRectMake(10, 10, 50, 50)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.backgroundColor = UIColor.whiteColor()
        self.friendAvatar.image = nil
    }

}
