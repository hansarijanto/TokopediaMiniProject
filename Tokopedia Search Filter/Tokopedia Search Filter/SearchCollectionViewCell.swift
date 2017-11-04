//
//  SearchCollectionViewCell.swift
//  Tokopedia Search Filter
//
//  Created by Hans Arijanto on 11/3/17.
//  Copyright © 2017 Hans Arijanto. All rights reserved.
//


import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    public let imageView  : UIImageView = UIImageView()
    public let titleLabel : UILabel     = UILabel()
    public let priceLabel : UILabel     = UILabel()
    
    private let imagePadding: CGFloat = 8.0 // padding on left, right and top
    private let titleLabelSidePadding : CGFloat = 8.0
    private let titleLabelTopPadding  : CGFloat = 10.0
    
    private let priceLabelSidePadding : CGFloat = 8.0
    private let priceLabelBottomPadding  : CGFloat = 15.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageWidth = self.contentView.frame.size.width - self.imagePadding * 2.0
        self.imageView.frame = CGRect(x: self.imagePadding, y: self.imagePadding, width: imageWidth, height: imageWidth)
        self.contentView.addSubview(self.imageView)
        
        let labelWidth = self.contentView.frame.size.width - self.titleLabelSidePadding * 2.0
        titleLabel.frame = CGRect(x: self.titleLabelSidePadding, y: self.imageView.frame.maxY + self.titleLabelTopPadding, width: labelWidth, height: 50.0)
        titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        titleLabel.numberOfLines = 2
        self.contentView.addSubview(self.titleLabel)
        
        priceLabel.frame = CGRect(x: self.priceLabelSidePadding, y: self.self.contentView.frame.maxY - self.priceLabelBottomPadding - 30.0, width: labelWidth, height: 30.0)
        priceLabel.font = UIFont.systemFont(ofSize: 14.0)
        priceLabel.textColor = UIColor(red: 255.0/255.0, green: 116.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        self.contentView.addSubview(self.priceLabel)
        
        self.backgroundColor = UIColor.white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
