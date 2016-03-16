//
//  FXDownloadsController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/18/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXDownloadsController: UITableViewController {
    
    weak var viewModel : FXDownloadsViewModel?
    
    // MARK: - Init
    
    init(style: UITableViewStyle,bindedViewModel:FXDownloadsViewModel) {
        
        self.viewModel = bindedViewModel
        
        super.init(style: style)
        
        self.tabBarItem = UITabBarItem(title: "Downloads", image: UIImage(named: "tabbar_downloads"), tag: 0)
        
        self.navigationItem.title = "Downloads"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View states
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewStyle()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View customize
    
    func tableViewStyle() {
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0)
        self.tableView.indicatorStyle = UIScrollViewIndicatorStyle.White
        
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.tableView.backgroundColor = UIColor ( red: 0.2228, green: 0.2228, blue: 0.2228, alpha: 1.0 )
        self.tableView.separatorColor = UIColor ( red: 0.2055, green: 0.2015, blue: 0.2096, alpha: 1.0 )
        
        self.view.backgroundColor = UIColor ( red: 0.1221, green: 0.1215, blue: 0.1227, alpha: 1.0 )
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
