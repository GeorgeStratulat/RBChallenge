//
//  Serializer.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation
import Alamofire

struct Serializer<T: Decodable>: ResponseSerializer {
    func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> T {
        guard error == nil else {
            throw error!
        }
        
        guard let statusCode = response?.statusCode,
              200...299 ~= statusCode else {
            // first we try to treat errors based on the error key from backend
            if let error = error {
                throw NetworkError.custom(reason: error.localizedDescription)
            } else if let code = response?.statusCode {
                throw NetworkError.unacceptableCode(code: code)
            } else {
                throw NetworkError.undefined
            }
        }
        
        // if status code is acceptable and no error message, we should be able to decode our type
        let resp = try DecodableResponseSerializer<T>().serialize(request: request,
                                                                 response: response,
                                                                 data: data,
                                                                 error: error)
        return resp
    }
}
