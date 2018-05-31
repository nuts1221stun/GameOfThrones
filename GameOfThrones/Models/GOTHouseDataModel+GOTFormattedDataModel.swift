//
//  GOTHouseDataModel+GOTFormattedDataModel.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 31/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

extension GOTHouseDataModel: GOTFormattedDataModelProtocol {
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
        if let region = self.region {
            key = "Region"
            dict[key] = [region]
            fields.append(key)
        }
        if let coatOfArms = self.coatOfArms {
            key = "Coat of arms"
            dict[key] = [coatOfArms]
            fields.append(key)
        }
        if let words = self.words {
            key = "Words"
            dict[key] = [words]
            fields.append(key)
        }
        if let titles = self.titles {
            key = "Titles"
            dict[key] = titles
            fields.append(key)
        }
        if let seats = self.seats {
            key = "Seats"
            dict[key] = seats
            fields.append(key)
        }
        if let currentLordURL = self.currentLordURL {
            key = "Current lord"
            dict[key] = [currentLordURL]
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let heirURL = self.heirURL {
            key = "Heir"
            dict[key] = [heirURL]
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let overlordURL = self.overlordURL {
            key = "Overlord"
            dict[key] = [overlordURL]
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let founded = self.founded {
            key = "Founded"
            dict[key] = [founded]
            fields.append(key)
        }
        if let founderURL = self.founderURL {
            key = "Founder"
            dict[key] = [founderURL]
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let diedOut = self.diedOut {
            key = "Died out"
            dict[key] = [diedOut]
            fields.append(key)
        }
        if let ancestralWeapons = self.ancestralWeapons {
            key = "Ancestral weapons"
            dict[key] = ancestralWeapons
            fields.append(key)
        }
        if let cadetBranchURLs = self.cadetBranchURLs {
            key = "Cadet branches"
            dict[key] = cadetBranchURLs
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        if let swornMemberURLs = self.swornMemberURLs {
            key = "Sworn members"
            dict[key] = swornMemberURLs
            fields.append(key)
            fieldsOfURLType.insert(key)
        }
        return (dict, fields, fieldsOfURLType)
    }
}
