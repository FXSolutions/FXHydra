import UIKit

class HRPlaylistCell: UITableViewCell {
    
    var albumTitle : UILabel
    var iconImage : UIImageView

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.albumTitle = UILabel()
        self.albumTitle.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        self.albumTitle.textColor = UIColor.blackColor()
        
        self.iconImage = UIImageView()
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.albumTitle)
        self.contentView.addSubview(self.iconImage)
        
        self.separatorInset = UIEdgeInsetsMake(0, 70, 0, 0)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.albumTitle.frame = CGRectMake(70, 20, screenSizeWidth-70, 30)
        self.iconImage.frame = CGRectMake(10, 10, 50, 50)
        
    }
    
    
}