//
//  GOTHouseCollectionViewController.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 28/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import UIKit

extension GOTHouseDataModel {
    func data() -> (dictionary: [String: [Any]], fields: [String], fieldsOfURLType: [String]) {
        var dict = [String: [Any]]()
        var fields = [String]()
        var fieldsOfURLType = [String]()
        var key: String
        if let name = self.name {
            key = "Name"
            dict[key] = [name]
            fields.append(key)
        }
        if let region = self.region {
            key = "Region"
            dict[key] = [region]
            fields.append(key)
        }
        if let coatOfArms = self.coatOfArms {
            key = "Coat of arms"
            dict[key] = [coatOfArms]
            fields.append(key)
        }
        if let words = self.words {
            key = "Words"
            dict[key] = [words]
            fields.append(key)
        }
        if let titles = self.titles {
            key = "Titles"
            dict[key] = titles
            fields.append(key)
        }
        if let seats = self.seats {
            key = "Seats"
            dict[key] = seats
            fields.append(key)
        }
        if let currentLordURL = self.currentLordURL {
            key = "Current lord"
            dict[key] = [currentLordURL]
            fields.append(key)
            fieldsOfURLType.append(key)
        }
        if let heirURL = self.heirURL {
            key = "Heir"
            dict[key] = [heirURL]
            fields.append(key)
            fieldsOfURLType.append(key)
        }
        if let overlordURL = self.overlordURL {
            key = "Overlord"
            dict[key] = [overlordURL]
            fields.append(key)
            fieldsOfURLType.append(key)
        }
        if let founded = self.founded {
            key = "Founded"
            dict[key] = [founded]
            fields.append(key)
        }
        if let founderURL = self.founderURL {
            key = "Founder"
            dict[key] = [founderURL]
            fields.append(key)
            fieldsOfURLType.append(key)
        }
        if let diedOut = self.diedOut {
            key = "Died out"
            dict[key] = [diedOut]
            fields.append(key)
        }
        if let ancestralWeapons = self.ancestralWeapons {
            key = "Ancestral weapons"
            dict[key] = ancestralWeapons
            fields.append(key)
        }
        if let cadetBranchURLs = self.cadetBranchURLs {
            key = "Cadet branches"
            dict[key] = cadetBranchURLs
            fields.append(key)
            fieldsOfURLType.append(key)
        }
        if let swornMemberURLs = self.swornMemberURLs {
            key = "Sworn members"
            dict[key] = swornMemberURLs
            fields.append(key)
            fieldsOfURLType.append(key)
        }
        return (dict, fields, fieldsOfURLType)
    }
}

class GOTHouseCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var houseDict: [String: [Any]]?
    private var fields: [String]?
    private var fieldsOfURLType: [String]?
    private var house: GOTHouseDataModel?
    
    convenience init(house: GOTHouseDataModel?) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout.init())
        if let house = house {
            self.house = house
            let data = house.data()
            self.houseDict = data.dictionary
            self.fields = data.fields
            self.fieldsOfURLType = data.fieldsOfURLType
        }
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
        self.collectionView!.register(GOTTextReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GOTTextReusableView.reuseIdentifier())
        self.collectionView?.backgroundColor = UIColor.white
        
        
        self.collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let fields = self.fields else {
            return 0
        }
        print("section count: \(fields.count)")
        return fields.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let fieldsOfURLType = self.fieldsOfURLType, let fields = self.fields,
            fieldsOfURLType.contains(fields[section]) {
            return 0
        }
        guard let houseDict = self.houseDict,
            let fields = self.fields else {
            return 0
        }
        guard let array = houseDict[fields[section]] as? [String] else {
            return 0
        }
        print("\(section) item count: \(array.count)")
        return array.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GOTTextReusableView.reuseIdentifier(), for: indexPath)
        
        if kind != UICollectionElementKindSectionHeader {
            return view
        }
        
        guard let textView = view as? GOTTextReusableView,
        let fields = self.fields else {
                return view
        }
        let data = fields[indexPath.section]
        textView.populate(with: data)
        
        return textView
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GOTTextCell.reuseIdentifier(), for: indexPath)
        print("========populate: \(indexPath.section)-\(indexPath.item)")
        guard let textCell = cell as? GOTTextCell,
            let houseDict = self.houseDict,
            let fields = self.fields else {
            return cell
        }
        guard let data = houseDict[fields[indexPath.section]]?[indexPath.item] as? String else {
            return textCell
        }
        
        textCell.populate(with: data)
        
        return textCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let fields = self.fields else {
            return CGSize.zero
        }
        let data = fields[section]
        let size = GOTTextReusableView.sizeThatFits(CGSize.init(width: collectionView.bounds.width, height: CGFloat.greatestFiniteMagnitude), text: data)
        print("========header: \(section): \(size.width), \(size.height), \(data)")
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let houseDict = self.houseDict,
            let fields = self.fields,
            let data = houseDict[fields[indexPath.section]]?[indexPath.item] as? String else {
            return CGSize.zero
        }
        let size = GOTTextCell.sizeThatFits(CGSize.init(width: collectionView.bounds.width, height: CGFloat.greatestFiniteMagnitude), text: data)
        print("========cell: \(indexPath.section)-\(indexPath.item): \(size.width), \(size.height), \(data)")
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
