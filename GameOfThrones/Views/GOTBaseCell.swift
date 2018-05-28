//
//  GOTBaseCell.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 28/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import UIKit

class GOTBaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    internal func commonInit() {
    }
    
    static func reuseIdentifier() -> String {
        return String(describing: type(of: self))
    }
    
    class func sizeThatFits(_ size: CGSize, dataModel: GOTBaseCellDataModelProtocol?) -> CGSize {
        return CGSize.zero
    }
    
    func populate(with dataModel: GOTBaseCellDataModelProtocol?) {
        
    }
}
