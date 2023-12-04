//
//  NetworkService.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation

protocol NetworkService {
    /// Allows making a generic data request, using a `NetworkRequestable` type which contains information about request data and the desired output model
    func dataRequest<R: NetworkRequest>(for request: R) async throws -> R.responseModel
}
