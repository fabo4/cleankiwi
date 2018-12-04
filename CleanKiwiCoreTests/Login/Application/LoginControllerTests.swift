//
//  LoginControllerTests.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import XCTest
import CleanKiwiCore

class LoginControllerTests: XCTestCase {

    var invoker: LoginInvoker = LoginInvokerDummy()
    var loginResource: LoginResource = LoginResourceDummy()

    var sut: LoginController!

    override func setUp() {
        sut = LoginControllerImpl(invoker: invoker, loginResource: loginResource)
    }

    func test_whenCreate_thenIsNotLoading() {
        XCTAssertFalse(sut.isLoading())
    }

    func test_whenLogin_thenActionIsInvoked() {
        let invoker = LoginInvokerSpy()
        self.invoker = invoker
        setUp()

        sut.login(username: "username", password: "password")

        XCTAssertNotNil(invoker.action)
    }

    func test_whenLogin_thenControllerIsLoadingAndUpdates() {
        let invoker = LoginInvokerSpy()
        self.invoker = invoker
        setUp()
        var updateNotified = false
        sut.subscribeUpdate { updateNotified = true }

        sut.login(username: "username", password: "password")

        XCTAssertTrue(sut.isLoading())
        XCTAssertTrue(updateNotified)
    }

    func test_givenLogin_whenInvokerSuccessfulyCompletes_thenControllerIsNotLoadingAndUpdates() {
        let invoker = LoginInvokerSpy()
        self.invoker = invoker
        setUp()
        sut.login(username: "username", password: "password")
        var updateNotified = false
        sut.subscribeUpdate { updateNotified = true }

        invoker.completion?(Result.success(response: LoginResponse(token: "", userId: "")))

        XCTAssertFalse(sut.isLoading())
        XCTAssertTrue(updateNotified)
    }

    func test_givenLogin_whenInvokerFails_thenControllerIsNotLoadingAndNotifiesAboutError() {
        let invoker = LoginInvokerSpy()
        self.invoker = invoker
        setUp()
        sut.login(username: "username", password: "password")
        var errorNotified = false
        sut.subscribeFailure { _ in errorNotified = true }

        invoker.completion?(Result.failure(error: TestError.error))

        XCTAssertFalse(sut.isLoading())
        XCTAssertTrue(errorNotified)
    }

    func test_givenLogin_whenInvokerInvokesAction_thenResourceIsCalled() {
        let invoker = LoginInvokerSpy()
        self.invoker = invoker
        let loginResource = LoginResourceSpy()
        self.loginResource = loginResource
        setUp()
        sut.login(username: "username", password: "password")

        _ = try? invoker.action?()

        XCTAssertEqual(loginResource.request?.username, "username")
        XCTAssertEqual(loginResource.request?.password, "password")
    }

    func test_givenLogin_whenInvokerCompletesWithError_thenErrorIsNotified() {
        let invoker = LoginInvokerStub()
        self.invoker = invoker
        setUp()
        sut.login(username: "username", password: "password")
        var errorNotified = false
        sut.subscribeFailure { _ in errorNotified = true }

        invoker.completion?(Result.failure(error: TestError.error))

        XCTAssertTrue(errorNotified)
    }

    func test_givenLoginAndFailingResource_whenInvokerInvokesAction_thenActionThrows() {
        let loginResource = LoginResourceFailingStub()
        self.loginResource = loginResource
        let invoker = LoginInvokerStub()
        self.invoker = invoker
        setUp()
        sut.login(username: "username", password: "password")

        XCTAssertThrowsError(try invoker.action?())
    }

    func test_givenLoginAndSuccessResource_whenInvokerInvokesAction_thenActionReturnsResult() throws {
        let loginResource = LoginResourceSuccessStub()
        self.loginResource = loginResource
        let invoker = LoginInvokerStub()
        self.invoker = invoker
        setUp()
        sut.login(username: "username", password: "password")

        let result = try invoker.action?()

        XCTAssertNotNil(result)
    }
}
