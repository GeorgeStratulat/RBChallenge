//
//  Container.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation

final class Container {
    private var factories: [String: () -> Any] = [:]
    
    func register<T>(factory: @escaping () -> T) {
        let key = String(describing: T.self)
        factories[key] = factory
    }
    
    func resolve<T>() -> T {
        let key = String(describing: T.self)
        let factory = factories[key]!
        guard let result = factory() as? T else {
            fatalError("Cant resolve \(key)")
        }

        return result
    }

}
