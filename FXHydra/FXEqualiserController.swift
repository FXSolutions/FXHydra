//
//  FXEqualiserController.swift
//  FXHydra
//
//  Created by kioshimafx on 4/4/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

class FXEqualiserController: UIViewController {
    
    var hz60Slider : UISlider!
    var hz150Slider : UISlider!
    var hz400Slider : UISlider!
    var hz1kSlider : UISlider!
    var hz2_4kSlider : UISlider!
    var hz15kSlider : UISlider!
    
    override func loadView() {
        super.loadView()
        
        self.hz60Slider     = UISlider()
        self.hz150Slider    = UISlider()
        self.hz400Slider    = UISlider()
        self.hz1kSlider     = UISlider()
        self.hz2_4kSlider   = UISlider()
        self.hz15kSlider    = UISlider()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
