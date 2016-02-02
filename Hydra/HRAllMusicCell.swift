import UIKit

class HRAllMusicCell: UITableViewCell {
    
    var audioAristLabel         : AttributedLabel
    var audioTitleLabel         : AttributedLabel
    var audioDurationTime       : AttributedLabel!
    var audioBitrate            : AttributedLabel!
    var audioTimeLabel          : AttributedLabel!
    var progressView            : UIProgressView!
    var allMusicController      : AllMusicController!
    var audioModel              : HRAudioItemModel!
    var downloadedImage         : UIImageView!
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
        self.audioBitrate.font = UIFont(name: "HelveticaNeue-Light", size: 12)!
        self.audioBitrate.textColor = UIColor.whiteColor()
        self.audioBitrate.backgroundColor = UIColor.clearColor()
        self.audioBitrate.contentAlignment = .Center
        
        self.audioTimeLabel = AttributedLabel()
        self.audioTimeLabel.font = UIFont(name: "Avenir-Heavy", size: 14)!
        self.audioTimeLabel.textColor = UIColor.whiteColor()
        self.audioTimeLabel.backgroundColor = UIColor.clearColor()
        self.audioTimeLabel.contentAlignment = .Center
        
        self.progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        self.progressView.tintColor = UIColor.blackColor()
        self.progressView.hidden = true
        
        self.bitRateBackgroundImage = UIImageView()
        
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        //self.downloadButton.addTarget(self, action: "startDownload", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.downloadedImage = UIImageView()
        
        self.contentView.addSubview(self.downloadedImage)
        self.contentView.addSubview(self.audioAristLabel)
        self.contentView.addSubview(self.audioTitleLabel)
        
        self.contentView.addSubview(self.progressView)
        
        self.contentView.addSubview(self.bitRateBackgroundImage)
        self.contentView.addSubview(self.audioBitrate)
        self.contentView.addSubview(self.audioTimeLabel)
        
        
        self.contentView.backgroundColor = UIColor.clearColor()
        self.backgroundColor = UIColor.clearColor()
        
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //audioTitleLabel
        self.audioTitleLabel.frame = CGRectMake(self.separatorInset.left+40, 10, screenSizeWidth-70, 20)
        self.audioAristLabel.frame = CGRectMake(self.separatorInset.left+40, 40, screenSizeWidth-70, 20)
        self.progressView.frame = CGRectMake(0, self.contentView.frame.height-2, self.contentView.frame.width, 2)
        //self.downloadButton.frame = CGRectMake(self.contentView.frame.width-65, 5, 60, 60)
        
        
        self.downloadedImage.frame = CGRectMake(self.contentView.frame.width-35, 25, 20, 20)
        
        self.audioTimeLabel.frame = CGRectMake(self.separatorInset.left+2, 10, 30, 20)
        self.bitRateBackgroundImage.frame = CGRectMake(self.separatorInset.left+2, 40, 30, 20)
        self.audioBitrate.frame = CGRectMake(self.separatorInset.left+2, 40, 30, 20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.progressView.hidden = true
        
        //self.avatar.image = nil
        
    }
    
    func startDownload() {
        
        //self.downloadButton.hidden = true
        self.allMusicController.downloadAudio(self.audioModel, progressView: self.progressView)
        
    }
    
    
    

}
