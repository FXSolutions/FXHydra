//
//  HRMenuCell.swift
//  Hydra
//
//  Created by Evgeny Abramov on 7/12/15.
//  Copyright © 2015 Evgeny Abramov. All rights reserved.
//

import UIKit

class HRMenuCell: UITableViewCell {
    
    var iconImage : UIImageView
    var menuTextLabel : UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.menuTextLabel = UILabel()
        self.menuTextLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        self.menuTextLabel.textColor = UIColor.whiteColor()
        
        self.iconImage = UIImageView()
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.menuTextLabel)
        self.contentView.addSubview(self.iconImage)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.separatorInset = UIEdgeInsetsMake(0, 45, 0, 0)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.menuTextLabel.frame = CGRectMake(70, 8, 200, 30)
        self.iconImage.frame = CGRectMake(15, 8, 30, 30)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected == true {
            self.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 10/255, alpha: 0.2)
        } else {
            self.backgroundColor = UIColor.clearColor()
        }
        
    }

}
