//
//  ListViewModelTests.swift
//  RBChallengeTests
//
//  Created by George Stratulat on 03.12.2023.
//

import XCTest
@testable import RBChallenge

let mockUser = User(name: Name(title: "Mr", first: "George", last: "Stratulat"), email: "email@email.com", id: ID(name: "name", value: UUID().uuidString), picture: Picture(large: "www.large.com", medium: "www.medium.com", thumbnail: "www.thumbnail.com"))

class NetworkMock: NetworkService {
    func dataRequest<R: NetworkRequest>(for request: R) async throws -> R.responseModel {
        if let request = request as? DefaultRequest {
            return UsersResponse(results: Array(repeating: mockUser, count: request.results), info: Info(seed: "abc", results: request.results, page: request.page, version: "1.0")) as! R.responseModel
        }
        throw NetworkError.networkUnavailable
    }
}


final class ListViewModelTests: XCTestCase {
    var sut: ListViewModel!

    func testLoadInitialDataSuccess() async throws {
        sut = ListViewModel(networkService: NetworkMock())
        await sut.loadInitialData()
        XCTAssertEqual(sut.users.count, 20)
    }
    
    func testLoadMoreItemsSuccess() async throws {
        sut = ListViewModel(networkService: NetworkMock())
        await sut.loadData()
        XCTAssertEqual(sut.users.count, 20)
        await sut.loadMoreItems(index: 17)
        XCTAssertEqual(sut.users.count, 40)
    }
    
    func testLoadMoreItemsThresholdSuccess() async throws {
        sut = ListViewModel(networkService: NetworkMock())
        await sut.loadData()
        XCTAssertEqual(sut.users.count, 20)
        await sut.loadMoreItems(index: 17)
        await sut.loadMoreItems(index: 37)
        await sut.loadMoreItems(index: 57)
        // even though we loaded 80 items, there are 60, so the threshold succeeds
        XCTAssertEqual(sut.users.count, 60)
    }
    
    func testLoadMoreItemsSmallIndexSuccess() async throws {
        sut = ListViewModel(networkService: NetworkMock())
        await sut.loadData()
        XCTAssertEqual(sut.users.count, 20)
        
        // we load a smaller index, page is still the same
        await sut.loadMoreItems(index: 16)
        XCTAssertEqual(sut.users.count, 20)
    }
    
    func testLoadMoreItemsOffsetIndexSuccess() async throws {
        sut = ListViewModel(networkService: NetworkMock())
        await sut.loadData()
        XCTAssertEqual(sut.users.count, 20)
        
        // we load an offset index, page is still the same
        await sut.loadMoreItems(index: 100)
        XCTAssertEqual(sut.users.count, 20)
    }
    
}
