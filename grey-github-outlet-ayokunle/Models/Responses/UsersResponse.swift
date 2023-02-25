//
//  UsersResponse.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/25/23.
//

import Foundation

// MARK: UsersResponse
struct UsersResponse: Codable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: [Item]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
