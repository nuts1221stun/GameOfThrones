//
//  GOTBookDataModel+GOTFormattedDataModelProtocol.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 31/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

extension GOTBookDataModel: GOTFormattedDataModelProtocol {
    func data() -> (dictionary: [String: [Any]], fields: [String], fieldsOfURLType: Set<String>) {
        var dict = [String: [Any]]()
        var fields = [String]()
        var fieldsOfURLType = Set<String>.init()
        var key: String
        if let name = self.name {
            key = "Name"
            dict[key] = [name]
            fields.append(key)
        }
        if let isbn = self.isbn {
            key = "ISBN"
            dict[key] = [isbn]
            fields.append(key)
        }
        if let authors = self.authors {
            key = "Authors"
            dict[key] = authors
            fields.append(key)
        }
        if let numberOfPages = self.numberOfPages {
            key = "Number of pages"
            dict[key] = [numberOfPages]
            fields.append(key)
        }
        if let publisher = self.publisher {
            key = "Publisher"
            dict[key] = [publisher]
            fields.append(key)
        }
        if let country = self.country {
            key = "Country"
            dict[key] = [country]
            fields.append(key)
        }
        if let mediaType = self.mediaType {
            key = "Media type"
            dict[key] = [mediaType]
            fields.append(key)
        }
        if let released = self.released {
            key = "Released"
            dict[key] = [released]
            fields.append(key)
        }
        if let characterURLs = self.characterURLs {
            key = "Characters"
            dict[key] = characterURLs
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let povCharacterURLs = self.povCharacterURLs {
            key = "POV characters"
            dict[key] = povCharacterURLs
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        return (dict, fields, fieldsOfURLType)
    }
}
