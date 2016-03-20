//
//  FXPlaylistsController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/16/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXPlaylistsController: UITableViewController {
    
    var viewModel : FXPlaylistsViewModel?
    
    // MARK: - Init
    
    init(style: UITableViewStyle,bindedViewModel:FXPlaylistsViewModel) {
        
        self.viewModel = bindedViewModel
        
        super.init(style: style)
        
        self.tabBarItem = UITabBarItem(title: "Playlists", image: UIImage(named: "tabbar_playlists"), tag: 0)
        
        self.navigationItem.title = "Playlists"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewStyle()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View customize
    
    override func viewWillAppear(animated: Bool) {
        
        self.animateTable()
        
    }
    
    func animateTable() {
        
        self.tableView.reloadData()
        
        ////
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(0.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
        
    }
    
    func tableViewStyle() {
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.tableView.indicatorStyle = UIScrollViewIndicatorStyle.White
        
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.tableView.backgroundColor = UIColor ( red: 0.2228, green: 0.2228, blue: 0.2228, alpha: 1.0 )
        self.tableView.separatorColor = UIColor ( red: 0.2055, green: 0.2015, blue: 0.2096, alpha: 1.0 )
        
        self.view.backgroundColor = UIColor ( red: 0.1221, green: 0.1215, blue: 0.1227, alpha: 1.0 )
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

}
