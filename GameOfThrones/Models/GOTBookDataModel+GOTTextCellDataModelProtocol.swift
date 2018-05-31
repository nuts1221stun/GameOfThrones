//
//  GOTBookDataModel+GOTTextCellDataModelProtocol.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 31/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

extension GOTBookDataModel: GOTTextCellDataModelProtocol {
    var text: String? {
        get {
            return self.name
        }
    }
    var icon: String {
        get {
            return "📖"
        }
    }
}
