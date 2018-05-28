//
//  GOTHouseDataModel+TextCellProtocol.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 28/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

extension GOTHouseDataModel: GOTTextCellDataModelProtocol {
    var text: String? {
        get {
            return self.name
        }
    }
}
