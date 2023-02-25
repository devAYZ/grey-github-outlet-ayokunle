//
//  Endpoints.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/25/23.
//

import Foundation

// MARK: Endpoints for network calls
enum Endpoints: String {
    case https = "https://"
    
    case searchRepos = "/search/repositories"
    case searchUsers = "/search/users"
}
