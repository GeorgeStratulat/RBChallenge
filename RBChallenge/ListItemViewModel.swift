//
//  ContentViewModel.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation
import Combine

final class ListViewModel: ObservableObject {
    @Published var loading = false
    @Published var users = [User]()
    @Published var error: (Bool, String?) = (false, nil)
    
    private var page = 1
    private let itemsPerPage = 20
    
    let networkService: NetworkService
//    @InjectedDependency private var networkService: NetworkService
    
    init(networkService: NetworkService = NetworkImplementation()) {
        self.networkService = networkService
    }
    
    @MainActor
    private func updateView(with users: [User]) {
        self.loading = false
        self.users.append(contentsOf: users)
    }
    
    @MainActor
    private func setLoading(_ loading: Bool) {
        self.loading = loading
    }
    
    @MainActor
    private func showError(error: String) {
        self.error = (true, error)
    }
    
    func loadInitialData() async {
        page = 1
        await loadData()
    }
    
    func loadData() async {
        await setLoading(true)
        let request = DefaultRequest(page: page, results: itemsPerPage)
        do {
            let response = try await networkService.dataRequest(for: request)
            await updateView(with: response.results)
        } catch {
            await showError(error: error.localizedDescription)
            await setLoading(true)
        }
    }
    
    func loadMoreItems(index: Int) async {
        guard checkThreshold(index: index) else {
            return
        }
        self.page += 1
        await loadData()
    }
    
    private func checkThreshold(index: Int) -> Bool {
        // we load if there are 3 more items to be scrolled and also 3 pages
        return ((index + 3) == users.count) && (page < 3)
    }

}
