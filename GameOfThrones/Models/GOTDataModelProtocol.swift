//
//  GOTDataModelProtocol.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

protocol GOTDataModelProtocol {
    var name: String? { get }
    init(data: [String: Any]?)
}
