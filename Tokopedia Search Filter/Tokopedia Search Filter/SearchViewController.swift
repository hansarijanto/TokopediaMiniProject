//
//  SearchViewController.swift
//  Tokopedia Search Filter
//
//  Created by Hans Arijanto on 11/3/17.
//  Copyright © 2017 Hans Arijanto. All rights reserved.
//

import UIKit

// This is the search view controller, and the root controller of the mainVC

class SearchViewController: UIViewController, TokopediaProductManagerDelegate {
    
    private let navBarTitle     : String = "Search"       // bar title (Search)
    private let backgroundColor : UIColor = UIColor.white // background color (white)
    
    // collection view
    private let collectionView  : UICollectionView
    private let CVLayout        : SearchCollectionViewLayout = SearchCollectionViewLayout()
    
    private(set) var isLoadingData   : Bool = false // true when collection view is loading in more products
    private let activityView : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    private let fadeView     : UIView = UIView()
    
    public let YScrollLoadPadding: CGFloat = 70.0 // padding in pixels for the amount needed to load more data once the collection view has reached it's maxed scroll

    
    var fullImageView: UIImageView!
    
    init() {
        // create collection view with custom layout
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.CVLayout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set initialized params
        self.title = self.navBarTitle
        self.view.backgroundColor = self.backgroundColor
        
        // set collection view default values
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // TODO:: frame height not set correctly, doesn't scroll until the end
        self.collectionView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height - self.navigationController!.navigationBar.frame.height)
        self.collectionView.contentInset = UIEdgeInsetsMake(5.0, 0.0, 5.0, 0.0)
        self.collectionView.backgroundColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
        self.view.addSubview(self.collectionView)
        
        // setup loading view
        self.fadeView.frame = self.view.frame
        self.fadeView.backgroundColor = UIColor.black
        self.fadeView.alpha = 0.3
        self.fadeView.isHidden = true
        self.view.addSubview(fadeView)
        
        self.view.addSubview(activityView)
        activityView.hidesWhenStopped = true
        activityView.center = self.view.center
        
        TokopediaProductManager.shared.delegate = self // assign self as delegate
        self.loadMoreData() // load the first batch of data
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showLoadingUI() {
        DispatchQueue.main.async {
            self.fadeView.isHidden = false
            self.activityView.startAnimating()
        }
    }
    
    private func hideLoadingUI() {
        DispatchQueue.main.async {
            self.fadeView.isHidden = true
            self.activityView.stopAnimating()
        }
    }
    
    // function called when we want to download and load more products
    // called when we reach the end of the collection view
    public func loadMoreData() {
        if !self.isLoadingData {
            self.isLoadingData = true
            self.showLoadingUI()
            TokopediaProductManager.shared.getNextBatch() // set up call back
        }
    }
    
    // MARK: TokopediaProductManagerDelegate
    func didDownloadProducts(products: [TokopediaProduct]) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        self.hideLoadingUI()
        self.isLoadingData = false
    }
}


// MARK: collection view data source + delegate
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TokopediaProductManager.shared.products.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
        let products = TokopediaProductManager.shared.products
        let product = products[indexPath.row]
        
        // load product image
        if let url = URL(string: product.imageUrl) {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data : data)
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        DispatchQueue.main.async {
            cell.titleLabel.text = product.title
            cell.priceLabel.text = product.price
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY - self.YScrollLoadPadding > contentHeight - scrollView.frame.size.height {
            self.loadMoreData()
        }
    }
    
}
