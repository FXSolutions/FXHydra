//
//  HRDownloadedCell.swift
//  Hydra
//
//  Created by Evgeny Abramov on 9/14/15.
//  Copyright © 2015 Evgeny Abramov. All rights reserved.
//

import UIKit

class HRDownloadedCell: UITableViewCell {
    
    var audioAristLabel         : AttributedLabel!
    var audioTitleLabel         : AttributedLabel!
    var audioDurationTime       : AttributedLabel!
    var audioBitrate            : AttributedLabel!
    var bitRateBackgroundImage  : UIImageView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.audioTitleLabel = AttributedLabel()
        self.audioTitleLabel.font = UIFont(name: "Avenir-Heavy", size: 15)!
        self.audioTitleLabel.textColor = UIColor ( red: 0.9508, green: 0.9508, blue: 0.9508, alpha: 1.0 )
        self.audioTitleLabel.backgroundColor = UIColor.clearColor()
        
        self.audioAristLabel = AttributedLabel()
        self.audioAristLabel.font = UIFont(name: "HelveticaNeue-Light", size: 13)!
        self.audioAristLabel.textColor = UIColor ( red: 0.7805, green: 0.7768, blue: 0.7843, alpha: 1.0 )
        self.audioAristLabel.backgroundColor = UIColor.clearColor()
        
        self.audioBitrate = AttributedLabel()
        self.audioBitrate.font = UIFont(name: "Avenir-Medium", size: 12)!
        self.audioBitrate.textColor = UIColor.whiteColor()
        self.audioBitrate.backgroundColor = UIColor.clearColor()
        self.audioBitrate.contentAlignment = .Center
        
        self.audioDurationTime = AttributedLabel()
        self.audioDurationTime.font = UIFont(name: "Avenir-Heavy", size: 13)!
        self.audioDurationTime.textColor = UIColor.whiteColor()
        self.audioDurationTime.backgroundColor = UIColor.clearColor()
        self.audioDurationTime.contentAlignment = .Center
        
        self.bitRateBackgroundImage = UIImageView()
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.audioAristLabel)
        self.contentView.addSubview(self.audioTitleLabel)
        self.contentView.addSubview(self.audioBitrate)
        self.contentView.addSubview(self.audioDurationTime)
        
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
        
        self.audioTitleLabel.frame = CGRectMake(self.separatorInset.left, 10, screenSizeWidth-70, 20)
        self.audioAristLabel.frame = CGRectMake(self.separatorInset.left, 40, screenSizeWidth-70, 20)
        
        self.audioDurationTime.frame = CGRectMake(5, 10, 40, 20)
        self.bitRateBackgroundImage.frame = CGRectMake(10, 40, 30, 20)
        self.audioBitrate.frame = CGRectMake(10, 40, 30, 20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //self.progressView.hidden = true
        
        //self.avatar.image = nil
    }
    
    

}
