//
//  GOTTextReusableView.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 28/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import UIKit

class GOTTextReusableView: GOTBaseReusableView {
    private let textLabel = UILabel.init()
    
    static let insets = UIEdgeInsets.init(top: 8, left: 16, bottom: 4, right: 16)
    static let font = UIFont.systemFont(ofSize: 14, weight: .bold)
    
    override func commonInit() {
        self.backgroundColor = UIColor.white
        self .addSubview(self.textLabel)
        self.textLabel.font = type(of: self).font
        self.textLabel.numberOfLines = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = self.bounds
        frame.origin.x = type(of: self).insets.left
        frame.origin.y = type(of: self).insets.top
        frame.size.width -= type(of: self).insets.left + type(of: self).insets.right
        frame.size.height -= type(of: self).insets.top + type(of: self).insets.bottom
        self.textLabel.frame = frame
    }
    
    override static func sizeThatFits(_ size: CGSize, dataModel: GOTBaseCellDataModelProtocol?) -> CGSize {
        guard let textDataModel = dataModel as? GOTTextCellDataModelProtocol else {
            return CGSize.zero
        }
        return self.sizeThatFits(size, text: textDataModel.text)
    }
    
    static func sizeThatFits(_ size: CGSize, text: String?) -> CGSize {
        var boundingSize = size
        boundingSize.width -= self.insets.left + self.insets.right
        boundingSize.height -= self.insets.top + self.insets.bottom
        if var fittingSize = text?.sizeThatFits(boundingSize, font: self.font) {
            fittingSize.width = size.width
            fittingSize.height += self.insets.top + self.insets.bottom
            return fittingSize
        }
        return CGSize.zero
    }
    
    override func populate(with dataModel: GOTBaseCellDataModelProtocol?) {
        guard let textDataModel = dataModel as? GOTTextCellDataModelProtocol else {
            return
        }
        self.populate(with: textDataModel.text)
    }
    
    func populate(with text: String?) {
        self.textLabel.text = text
    }
}
