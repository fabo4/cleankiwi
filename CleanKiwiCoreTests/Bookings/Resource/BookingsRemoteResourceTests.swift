//
//  BookingsRemoteResourceTests.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import XCTest
import CleanKiwiCore

class BookingsRemoteResourceTests: XCTestCase {

    var networkClient: NetworkClient = NetworkClientDummy()
    var environmentConfig: EnvironmentConfig = EnvironmentConfigDummy()
    var resourceAuthenticator: ResourceAuthenticator = ResourceAuthenticatorDummy()

    var sut: BookingsResource!

    override func setUp() {
        sut = BookingsRemoteResource(networkClient: networkClient, environmentConfig: environmentConfig, resourceAuthenticator: resourceAuthenticator)
    }

    func test_givenNetworkClientThrows_whenGetBookings_thenItThrows() {
        let networkClient = NetworkClientStub()
        self.networkClient = networkClient
        setUp()


        XCTAssertThrowsError(try sut.bookings())
    }

    func test_givenBaseUrl_whenLogin_thenRequestUrlIsCorrect() {
        let environmentConfig = EnvironmentConfigStub()
        self.environmentConfig = environmentConfig
        let networkClient = NetworkClientSpy()
        self.networkClient = networkClient
        let resourceAuthenticator = ResourceAuthenticatorStub()
        self.resourceAuthenticator = resourceAuthenticator
        setUp()
        environmentConfig.baseUrl = "base_url"
        resourceAuthenticator.auth = "auth_string"

        _ = try? sut.bookings()

        XCTAssertEqual(networkClient.request?.parameters, [:])
        XCTAssertEqual(networkClient.request?.urlString, "base_url/users/self/bookings?v=2&auth_string")
        XCTAssertEqual(networkClient.request?.method, .get)
    }

    func test_givenNetworkClientReturnsBookings_whenGetBookings_thenBookingsAreReturned() throws {
        let networkClient = NetworkClientStub()
        self.networkClient = networkClient
        setUp()
        networkClient.response = NetworkClientResponse(body: .array([["bid": "bid1"], ["bid": "bid2"], ["asd": "asd"]]), statusCode: 200)

        let bookings = try sut.bookings()

        XCTAssertEqual(bookings.count, 2)
        XCTAssertEqual(bookings.first?.bid, "bid1")
        XCTAssertEqual(bookings.last?.bid, "bid2")
    }

    func test_givenNetworkClientReturnsDictionary_whenGetBookings_thenItThrowsIncorrectResponse() throws {
        let networkClient = NetworkClientStub()
        self.networkClient = networkClient
        setUp()
        networkClient.response = NetworkClientResponse(body: .dictionary(["bid": "bid1"]), statusCode: 200)

        XCTAssertThrowsError(try sut.bookings()) { error in
            if let loginError = error as? ResourceError {
                XCTAssertEqual(loginError, .incorrectResponse)
            } else {
                XCTFail()
            }
        }
    }

}
