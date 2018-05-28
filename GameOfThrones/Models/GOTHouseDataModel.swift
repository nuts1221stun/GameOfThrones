//
//  GOTHouseDataModel.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

class GOTHouseDataModel: GOTDataModelProtocol {
    
    private(set) var url: URL?
    private(set) var name: String?
    private(set) var region: String?
    private(set) var coatOfArms: String?
    private(set) var words: String?
    private(set) var titles: [String]?
    private(set) var seats: [String]?
    
    private(set) var currentLordURL: URL?
    private(set) var currentLord: GOTCharacterDataModel?
    
    private(set) var heirURL: URL?
    private(set) var heir: GOTCharacterDataModel?
    
    private(set) var overlordURL: URL?
    private(set) var overlord: GOTHouseDataModel?
    
    private(set) var founded: String?
    
    private(set) var founderURL: URL?
    private(set) var founder: GOTHouseDataModel?
    
    private(set) var diedOut: String?
    private(set) var ancestralWeapons: [String]?
    
    private(set) var cadetBranchURLs: [URL]?
    private(set) var cadetBranches: [GOTHouseDataModel]?
    
    private(set) var swornMemberURLs: [URL]?
    private(set) var swornMembers: [GOTCharacterDataModel]?
    
    required init(data: [String: Any]?) {
        guard let data = data else {
            return
        }
        self.url = data.url(from: "url")
        self.name = data["name"] as? String
        self.region = data["region"] as? String
        self.coatOfArms = data["coatOfArms"] as? String
        self.words = data["words"] as? String
        self.titles = data["titles"] as? [String]
        self.seats = data["seats"] as? [String]
        self.currentLordURL = data.url(from: "currentLord")
        self.heirURL = data.url(from: "heir")
        self.overlordURL = data.url(from: "overloard")
        self.founded = data["founded"] as? String
        self.diedOut = data["diedOut"] as? String
        self.ancestralWeapons = data["ancestralWeapons"] as? [String]
        self.cadetBranchURLs = data.urls(from: "cadetBranches")
        self.swornMemberURLs = data.urls(from: "swornMembers")
    }
}
