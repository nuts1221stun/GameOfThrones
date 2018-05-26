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
                        callback: @escaping ([[String: Any]]?, Error?) -> Void) {
        
        let url = URL.init(string: "houses", relativeTo: baseURL)
        let query = self.pageQuery(fromPage: page, pageSize: pageSize)
        GOTNetworkService.shared.request(withMethod: .GET, url: url, query: query, HTTPBody: nil, usesCookies: true) { (response, error) in
            if error != nil {
                callback(nil, error)
                return
            }
            guard let houses = response as? [[String: Any]] else {
                callback(nil, GOTNetwokServiceError.InvalidResponse)
                return
            }
            callback(houses, nil)
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
