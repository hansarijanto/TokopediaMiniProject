//
//  TokopediaProduct.swift
//  Tokopedia Search Filter
//
//  Created by Hans Arijanto on 11/3/17.
//  Copyright © 2017 Hans Arijanto. All rights reserved.
//

import Foundation

class TokopediaProductFilter {
    public var minPrice    : Int?  = nil
    public var maxPrice    : Int?  = nil
    public var isWholesale : Bool? = nil
    public var isOfficial  : Bool? = nil
    public var goldSeller  : Int?  = nil
    
    static let maxPriceRange : Int = 10000000
    static let minPriceRange : Int = 100
}

class TokopediaProduct {
    public let title    : String
    public let imageUrl : String
    public let price    : String
    
    init(title: String, imageUrl: String, price: String) {
        self.title    = title
        self.imageUrl = imageUrl
        self.price    = price
    }
}
