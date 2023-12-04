//
//  ListView.swift
//  RBChallenge
//
//  Created by George Stratulat on 04.12.2023.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ListViewModel()
    
    

    var body: some View {
        let usersList = viewModel.users.enumerated().map({ $0 })
        List(usersList, id: \.element.uid) { index, user in
            ListItemView(user: user)
                .onAppear {
                    Task {
                        await viewModel.loadMoreItems(index: index + 1)
                    }
                }
        }
        .listStyle(.plain)
        .overlay {
            if viewModel.loading {
                ProgressView()
            }
        }
        .alert("Error", isPresented: $viewModel.error.0) {
            Button("OK") { }
        } message: {
            Text(viewModel.error.1 ?? "")
        }
        .onAppear {
            Task {
                await viewModel.loadInitialData()
            }
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
