//
//  DefaultMock.swift
//  RBChallenge
//
//  Created by George Stratulat on 03.12.2023.
//

import Foundation

class DefaultMock: NetworkService {
    func dataRequest<R>(for request: R) async throws -> R.responseModel where R : NetworkRequest {
        if request is DefaultRequest {
            return UsersResponse(results: [User(gender: "Male", name: Name(title: "Mr", first: "George", last: "Stratulat"), location: Location(street: Street(number: 15, name: "Street"), city: "City", state: "State", country: "Country", postcode: 123, coordinates: Coordinates(latitude: "123", longitude: "123"), timezone: Timezone(offset: "", description: "")), email: "email@email.com", login: Login(uuid: "123", username: "username", password: "password", salt: "salt", md5: "md5", sha1: "sha1", sha256: "sha256"), dob: Dob(date: "Date", age: 12), registered: Dob(date: "Date", age: 12), phone: "123456", cell: "cell", id: ID(name: "name", value: "value"), picture: Picture(large: "www.large.com", medium: "www.medium.com", thumbnail: "www.thumbnail.com"), nat: "nat")], info: Info(seed: "abc", results: 1, page: 1, version: "1.0")) as! R.responseModel
        }
        throw NetworkError.networkUnavailable
    }
}
