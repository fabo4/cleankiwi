//
//  LoginRemoteResourceTests.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import XCTest
import CleanKiwiCore

class LoginRemoteResourceTests: XCTestCase {

    var networkClient: NetworkClient = NetworkClientDummy()
    var environmentConfig: EnvironmentConfig = EnvironmentConfigDummy()

    var sut: LoginResource!

    override func setUp() {
        sut = LoginRemoteResource(networkClient: networkClient, environmentConfig: environmentConfig)
    }

    func test_givenNetworkClientThrows_whenLogin_thenItThrows() {
        let networkClient = NetworkClientStub()
        self.networkClient = networkClient
        setUp()

        let request = LoginRequest(username: "", password: "")

        XCTAssertThrowsError(try sut.login(request: request))
    }

    func test_givenBaseUrl_whenLogin_thenRequestUrlIsCorrect() {
        let environmentConfig = EnvironmentConfigStub()
        self.environmentConfig = environmentConfig
        let networkClient = NetworkClientSpy()
        self.networkClient = networkClient
        setUp()
        environmentConfig.baseUrl = "base_url"
        environmentConfig.appId = "application_id"

        let request = LoginRequest(username: "username", password: "password")
        _ = try? sut.login(request: request)

        let expectedParameters = ["login": "username", "password": "password"]
        XCTAssertEqual(networkClient.request?.parameters, expectedParameters)
        XCTAssertEqual(networkClient.request?.urlString, "base_url/user.login?app_id=application_id")
        XCTAssertEqual(networkClient.request?.method, .post)
    }

    func test_givenNetworkReturnsInvalidLogin_whenLogin_thenItThrowsInvalidCredentials() {
        let networkClient = NetworkClientStub()
        self.networkClient = networkClient
        setUp()
        networkClient.response = NetworkClientResponse(body: .dictionary(["error_code": "INVALID_LOGIN"]), statusCode: 200)

        let request = LoginRequest(username: "", password: "")

        XCTAssertThrowsError(try sut.login(request: request)) { error in
            if let loginError = error as? LoginControllerError {
                XCTAssertEqual(loginError, .invalidCredentials)
            } else {
                XCTFail()
            }
        }
    }

    func test_givenNetworkReturnsError_whenLogin_thenItThrowsUnknownError() {
        let networkClient = NetworkClientStub()
        self.networkClient = networkClient
        setUp()
        networkClient.response = NetworkClientResponse(body: .dictionary(["error_code": "QWE"]), statusCode: 200)

        let request = LoginRequest(username: "", password: "")

        XCTAssertThrowsError(try sut.login(request: request)) { error in
            if let loginError = error as? LoginControllerError {
                XCTAssertEqual(loginError, .unknown)
            } else {
                XCTFail()
            }
        }
    }

    func test_givenNetworkReturnsArray_whenLogin_thenItThrowsUnknownError() {
        let networkClient = NetworkClientStub()
        self.networkClient = networkClient
        setUp()
        networkClient.response = NetworkClientResponse(body: .array([["error_code": "QWE"]]), statusCode: 200)

        let request = LoginRequest(username: "", password: "")

        XCTAssertThrowsError(try sut.login(request: request)) { error in
            if let loginError = error as? LoginResourceError {
                XCTAssertEqual(loginError, .incorrectResponse)
            } else {
                XCTFail()
            }
        }
    }

    func test_givenNetworkReturnsToken_whenLogin_thenItReturnsLoginResponse() throws {
        let networkClient = NetworkClientStub()
        self.networkClient = networkClient
        setUp()
        networkClient.response = NetworkClientResponse(body: .dictionary(["token": "tutoken", "user_id": "tuid"]), statusCode: 200)

        let request = LoginRequest(username: "", password: "")
        let response = try sut.login(request: request)

        XCTAssertEqual(response.token, "tutoken")
        XCTAssertEqual(response.userId, "tuid")
    }

    func test_givenNetworkResponseMissingToken_whenLogin_thenItThrowsIncorrectResponse() throws {
        let networkClient = NetworkClientStub()
        self.networkClient = networkClient
        setUp()
        networkClient.response = NetworkClientResponse(body: .dictionary(["qwe": "tutoken", "user_id": "tuid"]), statusCode: 200)

        let request = LoginRequest(username: "", password: "")

        XCTAssertThrowsError(try sut.login(request: request)) { error in
            if let loginError = error as? LoginResourceError {
                XCTAssertEqual(loginError, .incorrectResponse)
            } else {
                XCTFail()
            }
        }
    }

    func test_givenNetworkResponseMissingUserId_whenLogin_thenItThrowsIncorrectResponse() throws {
        let networkClient = NetworkClientStub()
        self.networkClient = networkClient
        setUp()
        networkClient.response = NetworkClientResponse(body: .dictionary(["token": "tutoken", "asd": "tuid"]), statusCode: 200)

        let request = LoginRequest(username: "", password: "")

        XCTAssertThrowsError(try sut.login(request: request)) { error in
            if let loginError = error as? LoginResourceError {
                XCTAssertEqual(loginError, .incorrectResponse)
            } else {
                XCTFail()
            }
        }
    }
}
