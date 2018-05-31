//
//  GOTItemCollectionViewController.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 31/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GOTItemCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var itemDict: [String: [Any]]?
    private var fields: [String]?
    private var fieldsOfURLType: Set<String>?
    private var item: (GOTDataModelProtocol & GOTFormattedDataModelProtocol)?
    
    convenience init(item: (GOTDataModelProtocol & GOTFormattedDataModelProtocol)?) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout.init())
        if let item = item {
            self.item = item
            let data = item.data()
            self.itemDict = data.dictionary
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
        
        self.navigationItem.title = self.item?.name
    
        self.collectionView?.contentInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 8, right: 0)
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.showsHorizontalScrollIndicator = false
    
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
        return fields.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let itemDict = self.itemDict,
            let fields = self.fields else {
                return 0
        }
        if let strings = itemDict[fields[section]] as? [String] {
            return strings.count
        }
        if let models = itemDict[fields[section]] as? [GOTDataModelProtocol] {
            return models.count
        }
        return 0
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
        guard let textCell = cell as? GOTTextCell,
            let itemDict = self.itemDict,
            let fields = self.fields else {
                return cell
        }
        if let string = itemDict[fields[indexPath.section]]?[indexPath.item] as? String {
            textCell.populate(with: string)
        }
        if let model = itemDict[fields[indexPath.section]]?[indexPath.item] as? GOTTextCellDataModelProtocol {
            textCell.populate(with: model)
        }
        
        return textCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let fields = self.fields else {
            return CGSize.zero
        }
        let data = fields[section]
        let size = GOTTextReusableView.sizeThatFits(CGSize.init(width: collectionView.bounds.width, height: CGFloat.greatestFiniteMagnitude), text: data)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let itemDict = self.itemDict,
            let fields = self.fields else {
                return CGSize.zero
        }
        var text: String?
        if let string = itemDict[fields[indexPath.section]]?[indexPath.item] as? String {
            text = string
        }
        if let model = itemDict[fields[indexPath.section]]?[indexPath.item] as? GOTDataModelProtocol {
            text = model.name
        }
        guard let _ = text else {
            return CGSize.zero
        }
        let size = GOTTextCell.sizeThatFits(CGSize.init(width: collectionView.bounds.width, height: CGFloat.greatestFiniteMagnitude), text: text)
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard elementKind == UICollectionElementKindSectionHeader,
            var itemDict = self.itemDict,
            let fieldsOfURLType = self.fieldsOfURLType,
            let fields = self.fields,
            fieldsOfURLType.contains(fields[indexPath.section]) else {
                return
        }
        guard let urls = itemDict[fields[indexPath.section]] as? [GOTURL],
            urls.count > 0 else {
                return
        }
        if urls[0].dataType == GOTHouseDataModel.self {
            var houses = [GOTHouseDataModel]()
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            dispatchGroup.notify(queue: .main) { [weak weakSelf = self] in
                guard houses.count > 0 else {
                    return
                }
                weakSelf?.itemDict?[fields[indexPath.section]] = houses
//                collectionView.reloadSections(IndexSet(indexPath.section...indexPath.section))
                collectionView.reloadData()
            }
            for url in urls {
                dispatchGroup.enter()
                GOTAPINetworkService.shared.fetchHouse(withURL: url.url, callback: { (house, error) in
                    if let house = house, error == nil {
                        houses.append(house)
                    }
                    dispatchGroup.leave()
                })
            }
            dispatchGroup.leave()
        } else if urls[0].dataType == GOTCharacterDataModel.self {
            var characters = [GOTCharacterDataModel]()
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            dispatchGroup.notify(queue: .main) { [weak weakSelf = self] in
                guard characters.count > 0 else {
                    return
                }
                weakSelf?.itemDict?[fields[indexPath.section]] = characters
//                collectionView.reloadSections(IndexSet(indexPath.section...indexPath.section))
                collectionView.reloadData()
            }
            for url in urls {
                dispatchGroup.enter()
                GOTAPINetworkService.shared.fetchCharacter(withURL: url.url, callback: { (character, error) in
                    if let character = character, error == nil {
                        characters.append(character)
                    }
                    dispatchGroup.leave()
                })
            }
            dispatchGroup.leave()
        } else if urls[0].dataType == GOTBookDataModel.self {
            var books = [GOTBookDataModel]()
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            dispatchGroup.notify(queue: .main) { [weak weakSelf = self] in
                guard books.count > 0 else {
                    return
                }
                weakSelf?.itemDict?[fields[indexPath.section]] = books
//                collectionView.reloadSections(IndexSet(indexPath.section...indexPath.section))
                collectionView.reloadData()
            }
            for url in urls {
                dispatchGroup.enter()
                GOTAPINetworkService.shared.fetchBook(withURL: url.url, callback: { (book, error) in
                    if let book = book, error == nil {
                        books.append(book)
                    }
                    dispatchGroup.leave()
                })
            }
            dispatchGroup.leave()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemDict = self.itemDict,
            let fields = self.fields else {
                return
        }
        if let item = itemDict[fields[indexPath.section]]?[indexPath.item] as? (GOTDataModelProtocol & GOTFormattedDataModelProtocol) {
            GOTNavigationManager.shared.showItem(item)
        }
    }

}
