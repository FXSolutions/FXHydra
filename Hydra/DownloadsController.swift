
import UIKit

class DownloadsController: UITableViewController {
    
    var downloadsAudios = Array<HRAudioItemModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Downloads"
        
        self.addLeftBarButton()
        
        
        self.tableView.registerClass(HRDownloadedCell.self, forCellReuseIdentifier: "HRDownloadedCell")
        self.tableView.rowHeight = 70
        
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
        //cell.audioDurationTime.text = self.durationFormater(Double(audio.duration))
        
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
}
