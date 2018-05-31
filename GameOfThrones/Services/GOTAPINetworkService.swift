//
//  GOTAPINetworkService.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

class GOTAPINetworkService {
    static let shared = GOTAPINetworkService.init()
    private init() {}
    
    let baseURL = URL.init(string: "https://www.anapioficeandfire.com/api/")
    
    func fetchHouseList(withPage page: Int?,
                        pageSize: Int?,
                        callback: @escaping ([GOTHouseDataModel]?, Error?) -> Void) {
        
        let url = URL.init(string: "houses", relativeTo: baseURL)
        let query = self.pageQuery(fromPage: page, pageSize: pageSize)
        GOTNetworkService.shared.request(withMethod: .GET, url: url, query: query, HTTPBody: nil, usesCookies: true) { (response, error) in
            if error != nil {
                callback(nil, error)
                return
            }
            guard let houseDicts = response as? [[String: Any]] else {
                callback(nil, GOTNetwokServiceError.InvalidResponse)
                return
            }
            let houses = houseDicts.dataModels(withType: GOTHouseDataModel.self)
            callback(houses, nil)
        }
    }
    
    func fetchHouse(withURL url: URL?,
                    callback: @escaping (GOTHouseDataModel?, Error?) -> Void) {
        guard let url = url else {
            callback(nil, GOTNetwokServiceError.InvalidRequest)
            return
        }
        GOTNetworkService.shared.request(withMethod: .GET, url: url, query: nil, HTTPBody: nil, usesCookies: true) { (response, error) in
            if error != nil {
                callback(nil, error)
                return
            }
            guard let houseDict = response as? [String: Any] else {
                callback(nil, GOTNetwokServiceError.InvalidResponse)
                return
            }
            let house = GOTHouseDataModel.init(data: houseDict)
            callback(house, nil)
        }
    }
    
    func fetchCharacter(withURL url: URL?,
                    callback: @escaping (GOTCharacterDataModel?, Error?) -> Void) {
        guard let url = url else {
            callback(nil, GOTNetwokServiceError.InvalidRequest)
            return
        }
        GOTNetworkService.shared.request(withMethod: .GET, url: url, query: nil, HTTPBody: nil, usesCookies: true) { (response, error) in
            if error != nil {
                callback(nil, error)
                return
            }
            guard let characterDict = response as? [String: Any] else {
                callback(nil, GOTNetwokServiceError.InvalidResponse)
                return
            }
            let character = GOTCharacterDataModel.init(data: characterDict)
            callback(character, nil)
        }
    }
    
    func fetchBook(withURL url: URL?,
                   callback: @escaping (GOTBookDataModel?, Error?) -> Void) {
        guard let url = url else {
            callback(nil, GOTNetwokServiceError.InvalidRequest)
            return
        }
        GOTNetworkService.shared.request(withMethod: .GET, url: url, query: nil, HTTPBody: nil, usesCookies: true) { (response, error) in
            if error != nil {
                callback(nil, error)
                return
            }
            guard let bookDict = response as? [String: Any] else {
                callback(nil, GOTNetwokServiceError.InvalidResponse)
                return
            }
            let book = GOTBookDataModel.init(data: bookDict)
            callback(book, nil)
        }
    }
    
    func pageQuery(fromPage page: Int?, pageSize: Int?) -> [String: Any]! {
        var query = [String: Any]()
        if let page = page {
            query["page"] = page
        }
        if let pageSize = pageSize {
            query["pageSize"] = pageSize
        }
        return query
    }
}
