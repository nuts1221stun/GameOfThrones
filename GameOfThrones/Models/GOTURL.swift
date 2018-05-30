//
//  GOTURL.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 30/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

class GOTURL {
    private(set) var url: URL!
    private(set) var dataType: GOTDataModelProtocol.Type!
    
    init?(url: String?) {
        guard let url = url else {
            return nil
        }
        self.url = URL.init(string: url)
        if url.range(of: "houses") != nil {
            dataType = GOTHouseDataModel.self
        } else if url.range(of: "characters") != nil {
            dataType = GOTCharacterDataModel.self
        } else {
            return nil
        }
    }
}

