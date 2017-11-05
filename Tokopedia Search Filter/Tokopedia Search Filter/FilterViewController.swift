//
//  FilterViewController.swift
//  Tokopedia Search Filter
//
//  Created by Hans Arijanto on 11/5/17.
//  Copyright © 2017 Hans Arijanto. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    private let backgroundColor : UIColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0) // background color (light gray)
    
    private let headerContainer : UIView   = UIView()
    public let cancelButton     : UIButton = UIButton()
    private let headerTitle     : UILabel  = UILabel()
    private let resetButton     : UIButton = UIButton()
    
    private let headerHeight            : CGFloat = 55.0
    private let headerContentSideOffset : CGFloat = 5.0
    
    private let filter : TokopediaProductFilter
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    init(filter: TokopediaProductFilter) {
        self.filter = filter
        // create collection view with custom layout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set initialized params
        self.view.backgroundColor = self.backgroundColor
        
        self.headerContainer.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: headerHeight)
        self.headerContainer.backgroundColor = .white
        self.view.addSubview(self.headerContainer)
        
        let cancelButtonWidth = self.headerHeight - 25.0
        self.cancelButton.frame = CGRect(x: 8.0, y: 12.5, width: cancelButtonWidth, height: cancelButtonWidth)
        self.cancelButton.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        self.cancelButton.setImage(UIImage(named: "x"), for: .normal)
        self.headerContainer.addSubview(self.cancelButton)
        
        self.headerTitle.frame = CGRect(x: self.cancelButton.frame.maxX + 10.0, y: 0.0, width: 80.0, height: self.headerHeight)
        self.headerTitle.textAlignment = .left
        self.headerTitle.text = "Filter"
        self.headerTitle.font = UIFont.systemFont(ofSize: 15.0)
        self.headerContainer.addSubview(self.headerTitle)
        
        self.resetButton.frame = CGRect(x: self.headerContainer.frame.size.width - self.headerContentSideOffset - 55.0, y: 0.0, width: 55.0, height: self.headerHeight)
        self.resetButton.titleLabel?.textAlignment = .right
        self.resetButton.setTitle("Reset", for: .normal)
        self.resetButton.setTitleColor(UIColor(red: 105.0/255.0, green: 188.0/255.0, blue: 110.0/255.0, alpha: 1.0), for: .normal)
        self.resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: 1.2)
        self.headerContainer.addSubview(self.resetButton)
    }
    
    @objc public func close() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
