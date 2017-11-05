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
    private let slider: RangeSlider = RangeSlider(frame: CGRect.zero)
    
    private let sliderContainer     : UIView  = UIView()
    private let sliderMinTitleLable : UILabel = UILabel()
    private let sliderMaxTitleLable : UILabel = UILabel()
    private let sliderMinLable      : UILabel = UILabel()
    private let sliderMaxLable      : UILabel = UILabel()
    
    private let wholeSaleSwitch : UISwitch = UISwitch()
    private let wholeSaleLabel  : UILabel  = UILabel()
    
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
        
        self.sliderContainer.frame = CGRect(x: 0.0, y: self.headerContainer.frame.maxY + 10.0, width: self.view.frame.size.width, height: 220.0)
        self.sliderContainer.backgroundColor = .white
        self.view.addSubview(self.sliderContainer)
        
        let sliderTitleFont = UIFont.systemFont(ofSize: 12.0)
        let sliderFont = UIFont.systemFont(ofSize: 15.0)
        
        self.sliderMinTitleLable.font = sliderTitleFont
        self.sliderMinTitleLable.text = "Minimum Price"
        self.sliderMinTitleLable.textColor = .lightGray
        self.sliderMinTitleLable.textAlignment = .left
        self.sliderMinTitleLable.frame = CGRect(x: 10.0, y: 10.0, width: 100.0, height: 20.0)
        self.sliderContainer.addSubview(self.sliderMinTitleLable)
        
        self.sliderMaxTitleLable.font = sliderTitleFont
        self.sliderMaxTitleLable.text = "Maximum Price"
        self.sliderMaxTitleLable.textColor = .lightGray
        self.sliderMaxTitleLable.textAlignment = .right
        self.sliderMaxTitleLable.frame = CGRect(x: self.sliderContainer.frame.maxX - 110.0, y: 10.0, width: 100.0, height: 20.0)
        self.sliderContainer.addSubview(self.sliderMaxTitleLable)
        
        self.sliderMinLable.font = sliderFont
        self.sliderMinLable.text = self.formatPriceForLabel(price: TokopediaProductFilter.minPriceRange)
        self.sliderMinLable.textAlignment = .left
        self.sliderMinLable.textColor = .gray
        self.sliderMinLable.frame = CGRect(x: 10.0, y: self.sliderMinTitleLable.frame.maxY + 5.0, width: 100.0, height: 20.0)
        self.sliderContainer.addSubview(self.sliderMinLable)
        
        self.sliderMaxLable.font = sliderFont
        self.sliderMaxLable.text = self.formatPriceForLabel(price: TokopediaProductFilter.maxPriceRange)
        self.sliderMaxLable.textAlignment = .right
        self.sliderMaxLable.textColor = .gray
        self.sliderMaxLable.frame = CGRect(x: self.sliderContainer.frame.maxX - 160.0, y: self.sliderMinTitleLable.frame.maxY + 5.0, width: 150.0, height: 20.0)
        self.sliderContainer.addSubview(self.sliderMaxLable)
        
        self.slider.trackHighlightTintColor = UIColor(red: 55.0/255.0, green: 172.0/255.0, blue: 62.0/255.0, alpha: 1.0)
        self.slider.addTarget(self, action: #selector(FilterViewController.rangeSliderValueChanged(_:)), for: .valueChanged)
        self.slider.lowerValue = 0.0
        self.slider.upperValue = 1.0
        self.view.addSubview(self.slider)
        
        self.wholeSaleSwitch.frame = CGRect(x: self.sliderContainer.frame.maxX - 10.0 - 50.0, y: self.sliderContainer.frame.size.height - 30.0 - 20.0, width: 30.0, height: 30.0)
        self.wholeSaleSwitch.addTarget(self, action: #selector(switchValueDidChange(sender:)), for: .valueChanged)
        self.sliderContainer.addSubview(self.wholeSaleSwitch)
        
        self.wholeSaleLabel.frame = CGRect(x: 10.0, y: self.sliderContainer.frame.size.height - 45.0, width: 100.0, height: 30.0)
        self.wholeSaleLabel.text = "Whole Sale"
        self.wholeSaleLabel.textAlignment = .left
        self.wholeSaleLabel.font = UIFont.systemFont(ofSize: 15.0)
        self.wholeSaleLabel.textColor = .gray
        self.sliderContainer.addSubview(self.wholeSaleLabel)
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        self.slider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length + 150.0,
                                    width: width, height: 31.0)
    }
    
    @objc func switchValueDidChange(sender:UISwitch!)
    {
        self.filter.isWholesale = sender.isOn
    }
    
    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        var minPrice = TokopediaProductFilter.minPriceRange + rangeSlider.lowerValue * TokopediaProductFilter.maxPriceRange - TokopediaProductFilter.minPriceRange
        minPrice = (round(minPrice/100))*100
        var maxPrice = TokopediaProductFilter.minPriceRange + rangeSlider.upperValue * TokopediaProductFilter.maxPriceRange - TokopediaProductFilter.minPriceRange
        maxPrice = (round(maxPrice/100))*100
        
        self.filter.minPrice = minPrice
        self.filter.maxPrice = maxPrice
        
        self.sliderMinLable.text = self.formatPriceForLabel(price: minPrice)
        self.sliderMaxLable.text = self.formatPriceForLabel(price: maxPrice)
    }
    
    private func formatPriceForLabel(price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .currency
        if let formattedPriceAmount = formatter.string(from: price as NSNumber) {
            return formattedPriceAmount
        }
        
        return "Rp 0"
    }
    
    @objc public func close() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
