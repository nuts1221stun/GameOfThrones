//
//  GOTListCollectionViewController.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 31/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import UIKit

class GOTListCollectionViewController<T: GOTDataModelProtocol & GOTTextCellDataModelProtocol>: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let itemsPerBatch = 10
    private var items = [T]()
    private var isFetchComplete = false
    
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout.init())
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = T.listTitle
        
        self.collectionView?.contentInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 8, right: 0)
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.showsHorizontalScrollIndicator = false
        
        self.collectionView!.register(GOTTextCell.self, forCellWithReuseIdentifier: GOTTextCell.reuseIdentifier())
        self.collectionView?.backgroundColor = UIColor.white
        
        self.fetchItemList()
    }
    
    func fetchItemList() {
        if isFetchComplete {
            return
        }
        let page = Int(floor(Double(self.items.count) / Double(self.itemsPerBatch))) + 1
        GOTAPINetworkService.shared.fetchList(withPage: page, pageSize: itemsPerBatch, dataType: T.self) { [weak weakSelf = self] (items, error) in
            if let items = items {
                if items.count < self.itemsPerBatch {
                    weakSelf?.isFetchComplete = true
                }
                weakSelf?.items += items
                DispatchQueue.main.async {
                    weakSelf?.collectionView?.reloadData()
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GOTTextCell.reuseIdentifier(), for: indexPath)
        
        guard let textCell = cell as? GOTTextCell else {
            return cell
        }
        let item = self.items[indexPath.item]
        textCell.populate(with: item)
        
        return textCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.items[indexPath.item]
        return GOTTextCell.sizeThatFits(CGSize.init(width: collectionView.bounds.width, height: CGFloat.greatestFiniteMagnitude), dataModel: item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = self.items[indexPath.item] as? (GOTDataModelProtocol & GOTFormattedDataModelProtocol) else {
            return
        }
        GOTNavigationManager.shared.showItem(item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.items.count - indexPath.item > 1 {
            return
        }
        self.fetchItemList()
    }
}
