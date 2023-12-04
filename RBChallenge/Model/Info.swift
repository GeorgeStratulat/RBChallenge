//
//  Info.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results, page: Int
    let version: String
}
