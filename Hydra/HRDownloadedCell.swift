//
//  HRDownloadedCell.swift
//  Hydra
//
//  Created by Evgeny Abramov on 9/14/15.
//  Copyright © 2015 Evgeny Abramov. All rights reserved.
//

import UIKit

class HRDownloadedCell: UITableViewCell {
    
    var audioAristLabel         : UILabel!
    var audioTitleLabel         : UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.audioTitleLabel = UILabel()
        self.audioTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        self.audioTitleLabel.textColor = UIColor.blackColor()
        
        self.audioAristLabel = UILabel()
        self.audioAristLabel.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        self.audioAristLabel.textColor = UIColor.grayColor()
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        
        self.contentView.addSubview(self.audioAristLabel)
        self.contentView.addSubview(self.audioTitleLabel)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.audioTitleLabel.frame = CGRectMake(self.separatorInset.left, 10, screenSizeWidth-70, 20)
        self.audioAristLabel.frame = CGRectMake(self.separatorInset.left, 40, screenSizeWidth-70, 20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //self.progressView.hidden = true
        
        //self.avatar.image = nil
    }
    
    

}
