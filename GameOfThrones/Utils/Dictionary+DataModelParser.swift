//
//  Dictionary+DataModelParser.swift
//  GameOfThrones
//
//  Created by Li-Erh Chang on 26/05/2018.
//  Copyright © 2018 nuts. All rights reserved.
//

import Foundation

extension Dictionary {
    func url(from field: String!) -> GOTURL? {
        guard let data = self as? [String: Any] else {
            return nil
        }
        guard let urlString = data[field] as? String,
        urlString.count > 0 else {
            return nil
        }
        return GOTURL.init(url: urlString)
    }
    func urls(from field: String!) -> [GOTURL]? {
        guard let data = self as? [String: Any] else {
            return nil
        }
        guard let urlStrings = data[field] as? [String] else {
            return nil
        }
        var urls = [GOTURL]()
        for urlString in urlStrings {
            guard urlString.count > 0,
                let url = GOTURL.init(url: urlString)else {
                continue
            }
            urls.append(url)
        }
        return urls.count == 0 ? nil : urls
    }
    func string(from field: String!) -> String? {
        guard let data = self as? [String: Any],
            let string = data[field] as? String else {
            return nil
        }
        if string.count == 0 {
            return nil
        }
        return string
    }
    func strings(from field: String!) -> [String]? {
        guard let data = self as? [String: Any] else {
            return nil
        }
        guard let strings = data[field] as? [String] else {
            return nil
        }
        var filteredStrings = [String]()
        for string in strings {
            if string.count == 0 {
                continue
            }
            filteredStrings.append(string)
        }
        return filteredStrings.count == 0 ? nil : filteredStrings
    }
}
