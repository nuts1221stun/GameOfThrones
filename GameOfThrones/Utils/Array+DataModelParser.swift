//
//  Array+DataModelParser.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

extension Array {
    func dataModels<T: GOTDataModelProtocol>(withType dataType:T.Type) -> [T] {
        guard let data = self as? [[String: Any]] else {
            return []
        }
        var dataModels = [T]()
        for dict in data {
            let dataModel = dataType.init(data: dict)
            dataModels.append(dataModel)
        }
        return dataModels
    }
}
