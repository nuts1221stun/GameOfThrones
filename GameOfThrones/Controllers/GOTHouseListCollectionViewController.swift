//
//  GOTHouseListCollectionViewController.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import UIKit

class GOTHouseListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var houses = [GOTHouseDataModel]()
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

        // Register cell classes
        self.collectionView!.register(GOTTextCell.self, forCellWithReuseIdentifier: GOTTextCell.reuseIdentifier())
        self.collectionView?.backgroundColor = UIColor.white
        
        self.fetchHouseList()
    }
    
    func fetchHouseList() {
        if isFetchComplete {
            return
        }
        let page = Int(floor(Double(self.houses.count) / 10)) + 1
        GOTAPINetworkService.shared.fetchHouseList(withPage: page, pageSize: 10) { [weak weakSelf = self] (houseDicts, error) in
            if let houses = houseDicts?.dataModels(withType: GOTHouseDataModel.self) {
                if houses.count < 10 {
                    weakSelf?.isFetchComplete = true
                }
                weakSelf?.houses += houses
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
        return self.houses.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GOTTextCell.reuseIdentifier(), for: indexPath)
        
        guard let textCell = cell as? GOTTextCell else {
            return cell
        }
        let house = self.houses[indexPath.item]
        textCell.populate(with: house)
    
        return textCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let house = self.houses[indexPath.item]
        return GOTTextCell.sizeThatFits(CGSize.init(width: collectionView.bounds.width, height: CGFloat.greatestFiniteMagnitude), dataModel: house)
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
        let house = self.houses[indexPath.item]
        let vc = GOTHouseCollectionViewController.init(house: house)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.houses.count - indexPath.item > 1 {
            return
        }
        self.fetchHouseList()
    }
}
