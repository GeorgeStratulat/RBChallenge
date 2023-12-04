//
//  DefaultMock.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation

class DefaultMock: NetworkService {
   
    func dataRequest<R>(for request: R) async throws -> R.responseModel where R : NetworkRequest {
        var results = [User]()
        for _ in 0..<20 {
            results.append(User(name: Name(title: "Mr", first: "George", last: "Stratulat"), email: "email@email.com", id: ID(name: "name", value: UUID().uuidString), picture: Picture(large: "www.large.com", medium: "www.medium.com", thumbnail: "www.thumbnail.com")))
        }
        if request is DefaultRequest {
            return UsersResponse(results: results, info: Info(seed: "abc", results: 1, page: 1, version: "1.0")) as! R.responseModel
        }
        throw NetworkError.networkUnavailable
    }
}
