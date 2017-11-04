//
//  SearchCollectionViewLayout.swift
//  Tokopedia Search Filter
//
//  Created by Hans Arijanto on 11/3/17.
//  Copyright © 2017 Hans Arijanto. All rights reserved.
//

import UIKit

class SearchCollectionViewLayout: UICollectionViewFlowLayout {
    
    let innerSpace         : CGFloat = 1.5
    let numberOfCellsOnRow : CGFloat = 2.0
    let heightWidthRatio   : CGFloat = 1.5
    
    
    override init() {
        super.init()
        self.minimumLineSpacing      = innerSpace
        self.minimumInteritemSpacing = innerSpace
        self.scrollDirection         = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.size.width / self.numberOfCellsOnRow) - (self.innerSpace / 2.0)
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width:itemWidth(), height:itemWidth() * self.heightWidthRatio)
        }
        get {
            return CGSize(width:itemWidth(),height:itemWidth() * self.heightWidthRatio)
        }
    }
    
    
}
