
import UIKit

class DownloadsController: UITableViewController {
    
    var downloadsAudios = Array<HRAudioItemModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Downloads"
        
        self.addLeftBarButton()
        
        self.tableView.registerClass(HRDownloadedCell.self, forCellReuseIdentifier: "HRDownloadedCell")
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.allowsMultipleSelectionDuringEditing = false
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0)
        self.tableView.indicatorStyle = UIScrollViewIndicatorStyle.White
        self.tableView.backgroundColor = UIColor ( red: 0.2228, green: 0.2228, blue: 0.2228, alpha: 1.0 )
        self.tableView.separatorColor = UIColor ( red: 0.2055, green: 0.2015, blue: 0.2096, alpha: 1.0 )
        
        self.view.backgroundColor = UIColor ( red: 0.1221, green: 0.1215, blue: 0.1227, alpha: 1.0 )
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getAllDownloads()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func addLeftBarButton() {
        
        
        let button = UIBarButtonItem(image: UIImage(named: "menuHumb"), style: UIBarButtonItemStyle.Plain, target: self, action: "openMenu")
        self.navigationItem.leftBarButtonItem = button
        
    }
    
    func openMenu() {
        
        HRInterfaceManager.sharedInstance.openMenu()
        
    }
    
    
    // mark: - tableView delegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.downloadsAudios.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let audio = self.downloadsAudios[indexPath.row]
        
        let cell:HRDownloadedCell = self.tableView.dequeueReusableCellWithIdentifier("HRDownloadedCell", forIndexPath: indexPath) as! HRDownloadedCell
        
        cell.audioAristLabel.text = audio.artist
        cell.audioTitleLabel.text = audio.title
        
        //cell.bitRateBackgroundImage.image = UIImage(named: "bitrate_background")?.imageWithColor2(UIColor ( red: 0.3735, green: 0.3735, blue: 0.3735, alpha: 1.0 ))
        
        cell.audioDurationTime.text = self.durationFormater(Double(audio.duration))
        
        cell.audioBitrate.text = "\(666)"
        
        cell.bitRateBackgroundImage.image = UIImage(named: "bitrate_background")?.imageWithColor2(UIColor ( red: 0.0657, green: 0.5188, blue: 0.7167, alpha: 1.0 ))
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        dispatch.async.main { () -> Void in
            
            let audioLocalModel = self.downloadsAudios[indexPath.row]
            
            HRPlayerManager.sharedInstance.items = self.downloadsAudios
            HRPlayerManager.sharedInstance.currentPlayIndex = indexPath.row
            HRPlayerManager.sharedInstance.playItem(audioLocalModel)
            
            self.presentViewController(PlayerController(), animated: true, completion: nil)
            
        }
        
    }

    // get all audios 
    
    func getAllDownloads() {
        
        HRDatabaseManager.sharedInstance.getAllDownloads { (audiosArray) -> () in
            
            self.downloadsAudios = audiosArray
            self.tableView.reloadData()
            
        }
        
    }
    
    func durationFormater(duration:Double) -> String {
        
        let min = Int(floor(duration / 60))
        let sec = Int(floor(duration % 60))
        
        if (sec < 10) {
            return "\(min):0\(sec)"
        } else {
            return "\(min):\(sec)"
        }
        
    }
}
