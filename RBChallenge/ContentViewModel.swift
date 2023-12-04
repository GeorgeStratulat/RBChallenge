//
//  ContentViewModel.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    @Published var loading = false
    @Published var users = [User]()
    @Published var error: (Bool, String?) = (false, nil)
    
    private var page = 1
    private let itemsPerPage = 20
    
    let networkService: NetworkService
//    @InjectedDependency private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    @MainActor
    private func updateView(with users: [User]) {
        self.loading = false
        self.users.append(contentsOf: users)
    }
    
    func loadInitialData() async {
        page = 1
        await loadData()
    }
    
    func loadData() async {
        self.loading = true
        let request = DefaultRequest(page: page, results: itemsPerPage)
        do {
            let response = try await networkService.dataRequest(for: request)
            await updateView(with: response.results)
        } catch {
            self.error = (true, error.localizedDescription)
            self.loading = false
        }
    }
    
    func loadMoreItems(index: Int) async {
        guard checkThreshold() else {
            return
        }
        self.page += 1
        await loadData()
    }
    
    private func checkThreshold() -> Bool {
        return page < 3
    }

}
