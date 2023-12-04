//
//  DependencyContainer.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation

final class DependencyContainer {
    private static var shared = DependencyContainer()
    private let container = Container()

    static func register<T>(_ dependency: T) {
        shared.container.register(factory: { dependency as T} )
    }
    
    static func resolve<T>() -> T {
        return shared.container.resolve()
    }
}

@propertyWrapper
final class InjectedDependency<T> {
    var wrappedValue: T

    init() {
        self.wrappedValue = DependencyContainer.resolve()
    }
}
