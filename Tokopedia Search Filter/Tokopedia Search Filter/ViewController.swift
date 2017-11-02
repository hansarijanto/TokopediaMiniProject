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
        HTTPManager.shared.get(urlString: "https://ace.tokopedia.com/search/v2.5/product?q=samsung&pmin=10000&pmax=100000&wholesale=true&official=true&fshop=2&start=0&rows=10", completionBlock: {(data: String) -> Void in
            print(data)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

