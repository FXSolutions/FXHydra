import UIKit

class HRAllMusicCell: UITableViewCell {
    
    var audioAristLabel         : AttributedLabel
    var audioTitleLabel         : AttributedLabel
    var audioDurationTime       : AttributedLabel!
    var progressView            : UIProgressView!
    var downloadButton          : UIButton!
    var allMusicController      : AllMusicController!
    var audioModel              : HRAudioItemModel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
        self.audioTitleLabel = AttributedLabel()
        self.audioTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 15)!
        self.audioTitleLabel.textColor = UIColor.blackColor()
        self.audioTitleLabel.backgroundColor = UIColor.whiteColor()
        
        self.audioAristLabel = AttributedLabel()
        self.audioAristLabel.font = UIFont(name: "HelveticaNeue-Light", size: 13)!
        self.audioAristLabel.textColor = UIColor.grayColor()
        self.audioAristLabel.backgroundColor = UIColor.whiteColor()
        
        self.progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        self.progressView.tintColor = UIColor.blackColor()
        self.progressView.hidden = true
        
        self.downloadButton = UIButton(type: UIButtonType.System)
        self.downloadButton.setImage(UIImage(named: "downloadButton"), forState: UIControlState.Normal)
        self.downloadButton.tintColor = UIColor.blackColor()

        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        self.downloadButton.addTarget(self, action: "startDownload", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.contentView.addSubview(self.audioAristLabel)
        self.contentView.addSubview(self.audioTitleLabel)
        self.contentView.addSubview(self.progressView)
        self.contentView.addSubview(self.downloadButton)
        
        
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
        self.downloadButton.frame = CGRectMake(self.contentView.frame.width-65, 5, 60, 60)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.progressView.hidden = true
        
        //self.avatar.image = nil
    }
    
    func startDownload() {
        
        self.downloadButton.hidden = true
        self.allMusicController.downloadAudio(self.audioModel, progressView: self.progressView)
        
    }
    
    
    

}
