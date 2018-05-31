//
//  GOTCharacterDataModel+GOTFormattedDataModelProtocol.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 31/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

extension GOTCharacterDataModel: GOTFormattedDataModelProtocol {
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
        if let gender = self.gender {
            key = "Gender"
            dict[key] = [gender]
            fields.append(key)
        }
        if let culture = self.culture {
            key = "Culture"
            dict[key] = [culture]
            fields.append(key)
        }
        if let born = self.born {
            key = "Born"
            dict[key] = [born]
            fields.append(key)
        }
        if let died = self.died {
            key = "Died"
            dict[key] = [died]
            fields.append(key)
        }
        if let titles = self.titles {
            key = "Titles"
            dict[key] = titles
            fields.append(key)
        }
        if let aliases = self.aliases {
            key = "Aliases"
            dict[key] = aliases
            fields.append(key)
        }
        if let fatherURL = self.fatherURL {
            key = "Father"
            dict[key] = [fatherURL]
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let motherURL = self.motherURL {
            key = "Mother"
            dict[key] = [motherURL]
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let spouseURL = self.spouseURL {
            key = "Spouse"
            dict[key] = [spouseURL]
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let allegianceURLs = self.allegianceURLs {
            key = "Allegiances"
            dict[key] = allegianceURLs
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let bookURLs = self.bookURLs {
            key = "Books"
            dict[key] = bookURLs
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let povBookURLs = self.povBookURLs {
            key = "POV Books"
            dict[key] = povBookURLs
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let tvSeries = self.tvSeries {
            key = "TV Series"
            dict[key] = tvSeries
            fields.append(key)
        }
        if let playedBy = self.playedBy {
            key = "Played by"
            dict[key] = playedBy
            fields.append(key)
        }
        return (dict, fields, fieldsOfURLType)
    }
}
