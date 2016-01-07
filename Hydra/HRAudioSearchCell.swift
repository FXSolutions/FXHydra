//
//  HRAudioSearchCell.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/22/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit

class HRAudioSearchCell: UITableViewCell {

    var audioAristLabel         : UILabel
    var audioTitleLabel         : UILabel
    var audioDurationTime       : UILabel!
    var progressView            : UIProgressView!
    var downloadedImage         : UIImageView!
    var searchController        : HRSearchAudioController!
    var audioModel              : HRAudioItemModel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.audioTitleLabel = UILabel()
        self.audioTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        self.audioTitleLabel.textColor = UIColor.blackColor()
        
        self.audioAristLabel = UILabel()
        self.audioAristLabel.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        self.audioAristLabel.textColor = UIColor.grayColor()
        
        self.progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        self.progressView.tintColor = UIColor.blackColor()
        self.progressView.hidden = true
        
        self.downloadedImage = UIImageView()
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.audioAristLabel)
        self.contentView.addSubview(self.audioTitleLabel)
        self.contentView.addSubview(self.progressView)
        self.contentView.addSubview(self.downloadedImage)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //audioTitleLabel
        self.audioTitleLabel.frame = CGRectMake(self.separatorInset.left, 10, screenSizeWidth-70, 20)
        self.audioAristLabel.frame = CGRectMake(self.separatorInset.left, 40, screenSizeWidth-70, 20)
        self.progressView.frame = CGRectMake(0, self.contentView.frame.height-2, self.contentView.frame.width, 2)
        self.downloadedImage.frame = CGRectMake(self.contentView.frame.width-35, 25, 20, 20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.progressView.hidden = true
        
        //self.avatar.image = nil
    }
    
    func startDownload() {
        
        
    }
}
