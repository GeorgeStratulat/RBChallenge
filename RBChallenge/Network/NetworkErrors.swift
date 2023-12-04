//
//  NetworkErrors.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation

struct CommonErrorCodes {
    static let requestTimeout = NSURLErrorTimedOut
    static let hostNotFound = NSURLErrorCannotFindHost
    static let offline = NSURLErrorNotConnectedToInternet
    static let dataNotAllowed = NSURLErrorDataNotAllowed
}

enum NetworkError: Error {
    case custom(reason: String)
    case unacceptableCode(code: Int)
    case networkUnavailable
    case requestTimeout
    case hostNotFound
    case undefined
}

extension NetworkError: Equatable { }
