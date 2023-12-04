//
//  User.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation

// MARK: - Result
struct User: Codable {
    var uid: String {
        id.value ?? UUID().uuidString
    }
    let name: Name
    let email: String
    let id: ID
    let picture: Picture
}

// MARK: - ID
struct ID: Codable {
    let name: String?
    var value: String?
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}
