//
//  GOTHouseDataModel.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

class GOTHouseDataModel: GOTDataModelProtocol {
    
    private(set) var url: GOTURL?
    private(set) var name: String?
    private(set) var region: String?
    private(set) var coatOfArms: String?
    private(set) var words: String?
    private(set) var titles: [String]?
    private(set) var seats: [String]?
    
    private(set) var currentLordURL: GOTURL?
    private(set) var currentLord: GOTCharacterDataModel?
    
    private(set) var heirURL: GOTURL?
    private(set) var heir: GOTCharacterDataModel?
    
    private(set) var overlordURL: GOTURL?
    private(set) var overlord: GOTHouseDataModel?
    
    private(set) var founded: String?
    
    private(set) var founderURL: GOTURL?
    private(set) var founder: GOTHouseDataModel?
    
    private(set) var diedOut: String?
    private(set) var ancestralWeapons: [String]?
    
    private(set) var cadetBranchURLs: [GOTURL]?
    private(set) var cadetBranches: [GOTHouseDataModel]?
    
    private(set) var swornMemberURLs: [GOTURL]?
    private(set) var swornMembers: [GOTCharacterDataModel]?
    
    required init(data: [String: Any]?) {
        guard let data = data else {
            return
        }
        self.url = data.url(from: "url")
        
        self.name = data.string(from: "name")
        self.region = data.string(from: "region")
        self.coatOfArms = data.string(from: "coatOfArms")
        self.words = data.string(from: "words")
        self.titles = data.strings(from: "titles")
        self.seats = data.strings(from: "seats")
        self.currentLordURL = data.url(from: "currentLord")
        self.heirURL = data.url(from: "heir")
        self.overlordURL = data.url(from: "overloard")
        self.founded = data.string(from: "founded")
        self.diedOut = data.string(from: "diedOut")
        self.ancestralWeapons = data.strings(from: "ancestralWeapons")
        self.cadetBranchURLs = data.urls(from: "cadetBranches")
        self.swornMemberURLs = data.urls(from: "swornMembers")
    }
}
