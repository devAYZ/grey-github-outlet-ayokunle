//
//  InfoPlistParser.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/25/23.
//

import Foundation

struct InfoPlistParser {
    static func getStringValue(key: String) -> String {
        guard let value = Bundle.main.infoDictionary?[key] as? String else {
            fatalError("Could not find value for: \(key)")
        }
        return value
    }
}
