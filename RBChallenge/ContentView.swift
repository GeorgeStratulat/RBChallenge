//
//  ContentView.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import SwiftUI

struct ContentView: View {
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .yellow
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    
    var body: some View {
        NavigationView {
            ListView()
                .navigationTitle("Users")
        }
        .background(.yellow)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
