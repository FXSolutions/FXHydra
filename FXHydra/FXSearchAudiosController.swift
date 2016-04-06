//
//  FXSearchAudiosController.swift
//  FXHydra
//
//  Created by kioshimafx on 4/3/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXSearchAudiosController: UITableViewController , UISearchResultsUpdating, UISearchControllerDelegate {

    
    var canSearch   = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        if canSearch == true {
            canSearch = false
            if searchController.searchBar.text != "" {
                log.debug("\(searchController.searchBar.text)")
                //self.loadSearch(searchController.searchBar.text)
            } else {
                //self.audios = Array<HRAudioItemModel>()
                self.tableView.reloadData()
                canSearch = true
            }
        }
        
    }

}
