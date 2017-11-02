//
//  ViewController.swift
//  Tokopedia Search Filter
//
//  Created by Hans Arijanto on 11/3/17.
//  Copyright © 2017 Hans Arijanto. All rights reserved.
//

import UIKit

// This is the mainVC, first CC shown when the app loads

class ViewController: UINavigationController {
    
    private let searchVC: SearchViewController = SearchViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set nav bar to be solid
        self.navigationBar.isTranslucent = false
        
        // set initial root vc
        self.pushViewController(self.searchVC, animated: true)
        TokopediaProductManager.shared.getNextBatch()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

