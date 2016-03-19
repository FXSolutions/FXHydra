//
//  FXPlayerController.swift
//  FXHydra
//
//  Created by kioshimafx on 3/18/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXPlayerController: UIViewController {
    
    weak var viewModel : FXPlayerViewModel?
    
    var toolBar : UIToolbar!
    
    // MARK: - Init
    
    init(bindedViewModel:FXPlayerViewModel) {
        
        self.viewModel = bindedViewModel
        
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View load
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor ( red: 0.3138, green: 0.3138, blue: 0.3138, alpha: 1.0 )
        
        self.toolBar = UIToolbar()
        
        self.view.addSubview(self.toolBar)
        
    }

    
    // MARK: - View states

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // clean navbar
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        // load some stuff
        
        self.loadNavButtons()
        self.loadAudioStateInfo()
        self.loadToolBar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let viewSize = self.view.frame.size
        
        self.toolBar.frame = CGRectMake(0, viewSize.height-44, viewSize.width, 44)
        
    }
    
    // MARK - Load audio state 
    
    func loadAudioStateInfo() {
        
        self.title = "1 of 54"
        
    }
    
    func loadToolBar() {
        
        // style
        
        self.toolBar.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        //self.toolBar.setShadowImage(UIImage().imageByTintColor(UIColor.whiteColor()), forToolbarPosition: UIBarPosition.Any)
        self.toolBar.translucent = true
        self.toolBar.backgroundColor = UIColor.clearColor()
        self.toolBar.tintColor = UIColor ( red: 0.0, green: 0.8408, blue: 1.0, alpha: 1.0)
        
        // items
        
        var items = [UIBarButtonItem]()
        
        //
        
        let flexSpaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let equalizer = UIBarButtonItem(image: UIImage(named: "toolbar_equalizer"), style: UIBarButtonItemStyle.Plain, target: self, action: "openEqualizer")
        
        let flexSpaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        //
        
        items.append(flexSpaceLeft)
        items.append(equalizer)
        items.append(flexSpaceRight)
        
        self.toolBar.setItems(items, animated: false)
        
    }
    
    // MARK - UI Customized
    
    func loadNavButtons() {
        
        let closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeControllerAction")
        self.navigationItem.leftBarButtonItem = closeButton
        
        ///
        
        let actionsButton = UIBarButtonItem(title: "Actions", style: UIBarButtonItemStyle.Plain, target: self, action: "navButtonActionsAction")
        self.navigationItem.rightBarButtonItem = actionsButton
        
    }
    
    // MARK - Actions
    
    func closeControllerAction() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func navButtonActionsAction() {
        
        log.debug("::: navButtonActionsAction :::")
        
    }
    
    func openEqualizer() {
        
        log.debug("::: openEqualizer :::")
        
    }
    

}
