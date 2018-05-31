//
//  GOTEntryViewController.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 31/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import UIKit

class GOTEntryViewController: UIViewController {
    
    private let kButtonSize: CGFloat = 50
    private let kButtonSpacing: CGFloat = 30
    
    private var houseButton: UIButton?
    private var characterButton: UIButton?
    private var bookButton: UIButton?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let houseButton = UIButton.init(type: .system)
        houseButton.setTitle("🏰", for: .normal)
        houseButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        houseButton.addTarget(self, action: #selector(didTapHouseButton), for: .touchUpInside)
        self.houseButton = houseButton
        
        let characterButton = UIButton.init(type: .system)
        characterButton.setTitle("👤", for: .normal)
        characterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        characterButton.addTarget(self, action: #selector(didTapCharacterButton), for: .touchUpInside)
        self.characterButton = characterButton
        
        let bookButton = UIButton.init(type: .system)
        bookButton.setTitle("📖", for: .normal)
        bookButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bookButton.addTarget(self, action: #selector(didTapBookButton), for: .touchUpInside)
        self.bookButton = bookButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Game of Thrones"
        
        guard let houseButton = self.houseButton,
            let characterButton = self.characterButton,
            let bookButton = self.bookButton else {
                return
        }

        self.view.addSubview(houseButton)
        self.view.addSubview(characterButton)
        self.view.addSubview(bookButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let houseButton = self.houseButton,
            let characterButton = self.characterButton,
            let bookButton = self.bookButton else {
                return
        }
        
        let horizontalInset = (CGFloat(self.view.bounds.width) - CGFloat(kButtonSize) * 3 - CGFloat(kButtonSpacing) * 2) / 2
        let verticalInset = (CGFloat(self.view.bounds.height) - CGFloat(kButtonSize)) / 2
        
        var x = horizontalInset
        let buttons = [houseButton, characterButton, bookButton]
        var frame: CGRect
        
        for button in buttons {
            frame = CGRect(x: x, y: verticalInset, width: kButtonSize, height: kButtonSize)
            button.frame = frame
            x += kButtonSize + kButtonSpacing
        }
    }

    @objc func didTapHouseButton() {
        GOTNavigationManager.shared.showHouseList()
    }

    @objc func didTapCharacterButton() {
        GOTNavigationManager.shared.showCharacterList()
    }
    
    @objc func didTapBookButton() {
        GOTNavigationManager.shared.showBookList()
    }
}
