//
//  GOTCellDataModelProtocols.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 28/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

protocol GOTBaseCellDataModelProtocol {
    
}

protocol GOTTextCellDataModelProtocol: GOTBaseCellDataModelProtocol {
    var text: String? { get }
    var icon: String { get }
}
