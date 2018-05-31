//
//  GOTNavigationManager.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 31/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import UIKit

class GOTNavigationManager {
    
    static let shared = GOTNavigationManager.init()
    var navigationController: UINavigationController?
    
    private init() {}
    
    func showItem(_ item: (GOTDataModelProtocol & GOTFormattedDataModelProtocol)?) {
        guard let item = item else {
            return
        }
        let vc = GOTItemCollectionViewController.init(item: item)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
