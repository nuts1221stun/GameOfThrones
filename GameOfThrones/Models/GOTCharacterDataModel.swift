//
//  GOTCharacterDataModel.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

class GOTCharacterDataModel: GOTDataModelProtocol {
    
    private(set) static var listTitle = "Characters"
    private(set) static var requestURLPathName = "characters"
    
    private(set) var url: GOTURL?
    private(set) var name: String?
    private(set) var gender: String?
    private(set) var culture: String?
    private(set) var born: String?
    private(set) var died: String?
    private(set) var titles: [String]?
    private(set) var aliases: [String]?
    private(set) var fatherURL: GOTURL?
    private(set) var motherURL: GOTURL?
    private(set) var spouseURL: GOTURL?
    private(set) var allegianceURLs: [GOTURL]?
    private(set) var bookURLs: [GOTURL]?
    private(set) var povBookURLs: [GOTURL]?
    private(set) var tvSeries: [String]?
    private(set) var playedBy: [String]?
    
    required init(data: [String : Any]?) {
        guard let data = data else {
            return
        }
        self.url = data.url(from: "url")
        self.name = data.string(from: "name")
        self.gender = data.string(from: "gender")
        self.culture = data.string(from: "culture")
        self.born = data.string(from: "born")
        self.died = data.string(from: "died")
        self.titles = data.strings(from: "titles")
        self.aliases = data.strings(from: "aliases")
        self.fatherURL = data.url(from: "father")
        self.motherURL = data.url(from: "mother")
        self.spouseURL = data.url(from: "spouse")
        self.allegianceURLs = data.urls(from: "allegiances")
        self.bookURLs = data.urls(from: "books")
        self.povBookURLs = data.urls(from: "povBooks")
        self.tvSeries = data.strings(from: "tvSeries")
        self.playedBy = data.strings(from: "playedBy")
        
        if self.name == nil,
            let aliases = self.aliases,
            aliases.count > 0 {
            self.name = "(\(aliases[0]))"
        }
    }
}
