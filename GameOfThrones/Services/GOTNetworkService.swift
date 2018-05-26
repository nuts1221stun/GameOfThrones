//
//  GOTNetworkService.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

enum GOTNetwokServiceError: Int, Error {
    
    case Unknown = 900
    case InvalidRequest = 901
    case InvalidResponse = 902
    
    var localizedDescription: String {
        switch self {
        case .Unknown:
            return "Unknown error"
        case .InvalidRequest:
            return "Invalid request"
        case .InvalidResponse:
            return "Invalid response"
        }
    }
    
    var _code: Int { return self.rawValue }
}

enum GOTHTTPMethod {
    case GET
    case POST
    case PUT
    case DELETE
}

class GOTNetworkService {
    static let shared = GOTNetworkService.init()
    private init() {}
    
    func request(withMethod method:GOTHTTPMethod,
                 url: URL?,
                 query: [String: Any]?,
                 HTTPBody: [String: Any]?,
                 usesCookies: Bool,
                 callback: @escaping (Any?, Error?) -> Void) {
        // TODO: implement POST, PUT, DELETE
        // TODO: implement usesCookies
        
        guard let requestURL = URL.init(string: self.queryString(from: query), relativeTo: url) else {
            callback(nil, GOTNetwokServiceError.InvalidRequest)
            return
        }
        let request = URLRequest.init(url: requestURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 1.0 )
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                callback(nil, error)
                return
            }
            guard let data = data else {
                callback(nil, nil)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            callback(json, nil)
        }
        task.resume()
    }
    
    func queryString(from query: [String: Any]?) -> String! {
        var queryString = "?"
        var separator = ""
        guard let query = query else {
            return queryString
        }
        for (key, value) in query {
            separator = queryString.count == 1 ? "" : "&"
            queryString += "\(separator)\(key)=\(value)"
            // TODO: deal with string array, e.g. q=1&q=2&q=3
        }
        return queryString
    }
}


