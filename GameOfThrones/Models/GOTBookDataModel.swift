//
//  GOTBookDataModel.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 31/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

class GOTBookDataModel: GOTDataModelProtocol {
    
    private(set) static var listTitle = "Books"
    private(set) static var requestURLPathName = "books"
    
    private(set) var url: GOTURL?
    private(set) var name: String?
    private(set) var isbn: String?
    private(set) var authors: [String]?
    private(set) var numberOfPages: String?
    private(set) var publisher: String?
    private(set) var country: String?
    private(set) var mediaType: String?
    private(set) var released: String?
    private(set) var characterURLs: [GOTURL]?
    private(set) var povCharacterURLs: [GOTURL]?
    
    required init(data: [String : Any]?) {
        guard let data = data else {
            return
        }
        self.url = data.url(from: "url")
        self.name = data.string(from: "name")
        self.isbn = data.string(from: "isbn")
        self.authors = data.strings(from: "authors")
        if let numberOfPages = data.int(from: "numberOfPages") {
            self.numberOfPages = "\(numberOfPages)"
        }
        self.publisher = data.string(from: "publisher")
        self.country = data.string(from: "country")
        self.mediaType = data.string(from: "mediaType")
        if let released = data.string(from: "released") {
            let fromDateFormatter = DateFormatter()
            fromDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date = fromDateFormatter.date(from: released) {
                self.released = toDateFormatter.string(from: date)
            }
        }
        self.characterURLs = data.urls(from: "characters")
        self.povCharacterURLs = data.urls(from: "povCharacters")
    }
}
