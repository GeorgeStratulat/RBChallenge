//
//  ContentViewModelTests.swift
//  RBChallengeTests
//
//  Created by George Stratulat on 03.12.2023.
//

import XCTest
@testable import RBChallenge

let mockUser = User(gender: "Male", name: Name(title: "Mr", first: "George", last: "Stratulat"), location: Location(street: Street(number: 15, name: "Street"), city: "City", state: "State", country: "Country", postcode: 123, coordinates: Coordinates(latitude: "123", longitude: "123"), timezone: Timezone(offset: "", description: "")), email: "email@email.com", login: Login(uuid: "123", username: "username", password: "password", salt: "salt", md5: "md5", sha1: "sha1", sha256: "sha256"), dob: Dob(date: "Date", age: 12), registered: Dob(date: "Date", age: 12), phone: "123456", cell: "cell", id: ID(name: "name", value: "value"), picture: Picture(large: "www.large.com", medium: "www.medium.com", thumbnail: "www.thumbnail.com"), nat: "nat")

class NetworkMock: NetworkService {
    func dataRequest<R: NetworkRequest>(for request: R) async throws -> R.responseModel {
        if let request = request as? DefaultRequest {
            return UsersResponse(results: Array(repeating: mockUser, count: request.results), info: Info(seed: "abc", results: request.results, page: request.page, version: "1.0")) as! R.responseModel
        }
        throw NetworkError.networkUnavailable
    }
}


final class ContentViewModelTests: XCTestCase {
    var sut: ContentViewModel!

    func testLoadInitialDataSuccess() async throws {
        sut = ContentViewModel(networkService: NetworkMock())
        await sut.loadInitialData()
        XCTAssertEqual(sut.users.count, 20)
    }
    
    func testLoadMoreItemsSuccess() async throws {
        sut = ContentViewModel(networkService: NetworkMock())
        await sut.loadData()
        XCTAssertEqual(sut.users.count, 20)
        await sut.loadMoreItems(index: 1)
        XCTAssertEqual(sut.users.count, 40)
    }
    
    func testLoadMoreItemsReachesThresholdSuccess() async throws {
        sut = ContentViewModel(networkService: NetworkMock())
        await sut.loadData()
        XCTAssertEqual(sut.users.count, 20)
        await sut.loadMoreItems(index: 1)
        await sut.loadMoreItems(index: 1)
        await sut.loadMoreItems(index: 1)
        // even though we loaded 80 items, there are 60, so the threshold succeeds
        XCTAssertEqual(sut.users.count, 60)
    }

}
