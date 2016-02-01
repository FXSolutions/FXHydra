import UIKit
import VK_ios_sdk

class HRPlaylistsController: UITableViewController {

    var albumsArray = Array<HRAlbumModel>()
    var loading = false
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Playlists"
        
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.loadAlbums()
        
        self.tableView.registerClass(HRPlaylistCell.self, forCellReuseIdentifier: "HRPlaylistCell")
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        self.addLeftBarButton()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    
    // MARK: - load all audio
    
    
    func loadAlbums() {
        
        if loading == false {
            loading = true
            let getAudio = VKRequest(method: "audio.getAlbums", parameters: ["count":100,"offset":self.albumsArray.count])
            
            getAudio.executeWithResultBlock({ (response) -> Void in
                
                let json = response.json as! Dictionary<String,AnyObject>
                let items = json["items"] as! Array<Dictionary<String,AnyObject>>
                
                
                for audioDict in items {
                    
                    print(audioDict)
                    
                    let jsonAlbumItem = JSON(audioDict)
                    let audioItemModel = HRAlbumModel(json: jsonAlbumItem)
                    
                    self.albumsArray.append(audioItemModel)
                    
                }
                
                self.tableView.reloadData()
                self.loading = false
                
                }, errorBlock: { (error) -> Void in
                    // error
                    print(error)
            })
        }
        
    }
    
    // mark: - tableView delegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let album = self.albumsArray[indexPath.row]
        
        let cell:HRPlaylistCell = self.tableView.dequeueReusableCellWithIdentifier("HRPlaylistCell", forIndexPath: indexPath) as! HRPlaylistCell
        
        cell.albumTitle.text = album.title
        cell.iconImage.image = UIImage(named: "albumsIcon")?.imageWithColor2(UIColor.grayColor())
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let album = self.albumsArray[indexPath.row]
        
        let playAlbumController = HRInPlaylistController()
        playAlbumController.album_id = album.album_id
        playAlbumController.title = album.title
        
        self.navigationController?.pushViewController(playAlbumController, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            //add code here for when you hit delete
        }
        
    }
    
    
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
//        if indexPath.row == self.audiosArray.count - 7 {
//            self.loadMoreAudios()
//        }
        
    }
    
    //MARK :- stuff
    
    
    func addLeftBarButton() {
        
        
        let button = UIBarButtonItem(image: UIImage(named: "menuHumb"), style: UIBarButtonItemStyle.Plain, target: self, action: "openMenu")
        self.navigationItem.leftBarButtonItem = button
        
    }
    
    func openMenu() {
        
        HRInterfaceManager.sharedInstance.openMenu()
        
    }
    
}
