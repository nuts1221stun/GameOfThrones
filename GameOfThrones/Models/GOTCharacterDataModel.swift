//
//  GOTCharacterDataModel.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

class GOTCharacterDataModel: GOTDataModelProtocol {
    
    private(set) var url: GOTURL?
    private(set) var name: String?
    
    required init(data: [String : Any]?) {
        guard let data = data else {
            return
        }
        self.url = data.url(from: "url")
        self.name = data.string(from: "name")
    }
}
