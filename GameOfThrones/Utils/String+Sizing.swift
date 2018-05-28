//
//  String+Sizing.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 27/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func sizeThatFits(_ size: CGSize, font: UIFont) -> CGSize {
        var fittingSize = self.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil).size
        fittingSize.width = ceil(fittingSize.width)
        fittingSize.height = ceil(fittingSize.height)
        return fittingSize
    }
}
