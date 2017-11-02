//
//  SearchCollectionViewCell.swift
//  Tokopedia Search Filter
//
//  Created by Hans Arijanto on 11/3/17.
//  Copyright © 2017 Hans Arijanto. All rights reserved.
//


import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(imageView)
        
        self.backgroundColor = UIColor.white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
