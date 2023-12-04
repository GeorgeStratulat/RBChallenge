//
//  Default.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation
import Alamofire

struct DefaultRequest: NetworkRequest {
    typealias responseModel = UsersResponse
    var path = "/api"
    let page: Int
    let results: Int
    let seed = "abc"
    var parameters: Parameters? {
        [
            "page": page,
            "results": results,
            "seed": seed
        ]
    }
}
