//
//  Dictionary+DataModelParser.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

extension Dictionary {
    func url(from field: String!) -> URL? {
        guard let data = self as? [String: Any] else {
            return nil
        }
        guard let urlString = data[field] as? String else {
            return nil
        }
        return URL.init(string: urlString)
    }
    func urls(from field: String!) -> [URL]? {
        guard let data = self as? [String: [String]] else {
            return nil
        }
        guard let urlStrings = data[field] else {
            return nil
        }
        var urls = [URL]()
        for urlString in urlStrings {
            guard let url = URL.init(string: urlString) else {
                continue
            }
            urls.append(url)
        }
        return urls
    }
}
