//
//  RBChallengeApp.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import SwiftUI

@main
struct RBChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//private extension RBChallengeApp {
//    func setupDependencyInjections() {
//        #if TEST
//        DependencyContainer.register(NetworkImplementation() as NetworkService)
//        #else
//        DependencyContainer.register(NetworkImplementation() as NetworkService)
//        #endif
//    }
//}
