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

}
