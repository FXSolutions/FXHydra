//
//  FXAllAudiosController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/18/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXAllAudiosController: UITableViewController {
    
    var viewModel : FXAllAudiosViewModel?
    
    // MARK: - Init
    
    init(style: UITableViewStyle,bindedViewModel:FXAllAudiosViewModel) {
        
        super.init(style: style)
        
        self.viewModel = bindedViewModel
        
        self.tabBarItem = UITabBarItem(title: "Audios", image: UIImage(named: "tabbar_allmusic"), tag: 0)
        
        self.navigationItem.title = "Audios"
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View states

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewStyle()
        
        // register cell
        
        self.tableView.registerClass(FXDefaultMusicCell.self, forCellReuseIdentifier: "FXDefaultMusicCell")
        
        // load data
        
        self.viewModel?.getAudios({ (compite) -> () in
            if compite == true {
                self.tableView.reloadData()
            }
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View customize 
    
    func tableViewStyle() {
        
        self.tableView.tableFooterView = UIView()
        
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel!.audiosArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let musicModel = self.viewModel?.audiosArray[indexPath.row]
        
        ///
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FXDefaultMusicCell", forIndexPath: indexPath) as! FXDefaultMusicCell
        cell.textLabel?.text = musicModel?.title
        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let musicModel = self.viewModel?.audiosArray[indexPath.row]
        
        FXPlayerService.sharedManager().startPlayAudioModel(musicModel!)
        
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


}
