//
//  TokopediaProductManager.swift
//  Tokopedia Search Filter
//
//  Created by Hans Arijanto on 11/3/17.
//  Copyright © 2017 Hans Arijanto. All rights reserved.
//

import Foundation

// Singleton, keeps track of all tokopedia products and it's filter
// and is responsible for its downloads

class TokopediaProductManager {
    private var products : [TokopediaProduct]     = [TokopediaProduct]()
    private let filter   : TokopediaProductFilter = TokopediaProductFilter()
    
    private var currentProductIndex : Int = 0
    private var isGettingBatch      : Bool = false // is true when sending a get request
    
    static let shared: TokopediaProductManager = TokopediaProductManager()
    
    private static let batchSize  : Int    = 10  // how many products we download per get request
    private static let rootUrl    : String = "https://ace.tokopedia.com/search/v2.5/product?q=samsung" // search key, hardcoded
    
    
    private func requestUrl() -> String {
        var url = TokopediaProductManager.rootUrl
        
        if let minPrice = filter.minPrice {
            url = url + "&pmin=" + String(minPrice)
        }
        
        if let maxPrice = filter.maxPrice {
            url = url + "&pmax=" + String(maxPrice)
        }
        
        if let isWholesale = filter.isWholesale {
            url = url + "&wholesale="
            
            if isWholesale {
                url = url + "true"
            } else {
                url = url + "false"
            }
        }
        
        if let isOfficial = filter.isOfficial {
            url = url + "&official="
            
            if isOfficial {
                url = url + "true"
            } else {
                url = url + "false"
            }
        }
        
        if let goldSeller = filter.goldSeller {
            url = url + "&fshop=" + String(goldSeller)
        }
        
        url = url + "&rows=" + String(self.currentProductIndex)
        url = url + "&rows=" + String(TokopediaProductManager.batchSize)
        
        return url
    }
    
    // remove all stored products and reset product index
    public func resetProducts() {
        self.products = [TokopediaProduct]()
        self.currentProductIndex = 0
    }
    
    // download next batch of products and add products to list
    public func getNextBatch() {
        if isGettingBatch {
            return
        }
        
        self.isGettingBatch = true
        
        weak var weakSelf = self
        HTTPManager.shared.get(urlString: self.requestUrl(), completionBlock: {(dataString: String) -> Void in
            if let strongSelf = weakSelf {
                var dataDict: [String: Any] = [String: Any]()
                if let data = dataString.data(using: .utf8) {
                    do {
                        dataDict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                if let productsData = dataDict["data"] as? [[String: Any]] {
                    for productData in productsData {
                        if let productName  = productData["name"] as? String, let productPrice = productData["price"] as? String, let imageUrl = productData["uri"] as? String {
                            let product = TokopediaProduct(title: productName, imageUrl: imageUrl, price: productPrice)
                            strongSelf.products.append(product)
                        }
                    }
                }
                
                strongSelf.currentProductIndex += TokopediaProductManager.batchSize // increment batch size
                strongSelf.isGettingBatch = false
            }
        })
    }
}
