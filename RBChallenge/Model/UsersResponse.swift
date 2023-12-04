//
//  UsersResponse.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let results: [User]
    let info: Info
}
