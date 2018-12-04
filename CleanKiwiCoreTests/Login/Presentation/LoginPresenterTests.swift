//
//  LoginPresenterTests.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 27/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import XCTest
@testable import CleanKiwiCore

class LoginPresenterTests: XCTestCase {

    private var loginController: LoginController = LoginControllerDummy()

    private var sut: LoginPresenterImpl!

    private var viewSpy: LoginViewSpy!

    override func setUp() {
        super.setUp()
        sut = LoginPresenterImpl(loginController: loginController)
        viewSpy = LoginViewSpy()
        sut.view = viewSpy
    }

    func test_whenViewDidLoad_thenViewIsLocalizedAndNotLoadingAndErrorEmpty() {
        sut.viewDidLoad()

        XCTAssertEqual(viewSpy.localization?.usernamePlaceholder, "Email")
        XCTAssertEqual(viewSpy.localization?.passwordPlaceholder, "Password")
        XCTAssertEqual(viewSpy.localization?.loginButtonLabel, "Login")
        XCTAssertEqual(viewSpy.shownError, "")
        XCTAssertTrue(viewSpy.stopLoadingCalled)
    }

    func test_whenViewDidLoad_thenLoginControllerIsSubscribed() {
        let loginController = LoginControllerSpy()
        self.loginController = loginController
        setUp()

        sut.viewDidLoad()

        XCTAssertNotNil(loginController.update)
        XCTAssertNotNil(loginController.failure)
    }

    func test_givenViewDidLoadLoginControllerIsLoading_whenLoginControllerUpdates_thenViewStartsLoading() {
        let loginController = LoginControllerStub()
        self.loginController = loginController
        setUp()
        loginController.loading = true
        sut.viewDidLoad()

        loginController.update?()

        XCTAssertTrue(viewSpy.startLoadingCalled)
    }

    func test_givenViewDidLoadLoginControllerIsNotLoading_whenLoginControllerUpdates_thenViewStopsLoading() {
        let loginController = LoginControllerStub()
        self.loginController = loginController
        setUp()
        loginController.loading = false
        sut.viewDidLoad()
        viewSpy.stopLoadingCalled = false

        loginController.update?()

        XCTAssertTrue(viewSpy.stopLoadingCalled)
    }

    func test_givenViewDidLoadLoginControllerIsLoading_whenLoginControllerFails_thenViewStartsLoading() {
        let loginController = LoginControllerStub()
        self.loginController = loginController
        setUp()
        loginController.loading = true
        sut.viewDidLoad()

        loginController.failure?(TestError.error)

        XCTAssertTrue(viewSpy.startLoadingCalled)
    }

    func test_givenViewDidLoadLoginControllerIsNotLoading_whenLoginControllerFails_thenViewStopsLoading() {
        let loginController = LoginControllerStub()
        self.loginController = loginController
        setUp()
        loginController.loading = false
        sut.viewDidLoad()
        viewSpy.stopLoadingCalled = false

        loginController.failure?(TestError.error)

        XCTAssertTrue(viewSpy.stopLoadingCalled)
    }

    func test_givenViewDidLoadAndLoginControllerFailed_whenLogin_thenErrorIsEmpty() {
        let loginController = LoginControllerStub()
        self.loginController = loginController
        setUp()
        sut.viewDidLoad()
        loginController.failure?(LoginControllerError.invalidCredentials)

        sut.login(username: "username", password: "password")

        XCTAssertEqual(viewSpy.shownError, "")
    }

    func test_givenLoginCredentials_whenLogin_thenControllerLogsIn() {
        let loginController = LoginControllerSpy()
        self.loginController = loginController
        setUp()

        sut.login(username: "username", password: "password")

        XCTAssertEqual(loginController.username, "username")
        XCTAssertEqual(loginController.password, "password")
    }

    func test_givenDirtyLoginCredentials_whenLogin_thenControllerLogsInWithLowercaseTrimmedUsername() {
        let loginController = LoginControllerSpy()
        self.loginController = loginController
        setUp()

        sut.login(username: " USERname  ", password: "password")

        XCTAssertEqual(loginController.username, "username")
        XCTAssertEqual(loginController.password, "password")
    }

    func test_givenViewDidLoad_whenLoginControllerFailsWithInvalidCredentials_thenViewShowsErrorInvalidCredentials() {
        let loginController = LoginControllerStub()
        self.loginController = loginController
        setUp()
        sut.viewDidLoad()
        viewSpy.stopLoadingCalled = false

        loginController.failure?(LoginControllerError.invalidCredentials)

        XCTAssertTrue(viewSpy.stopLoadingCalled)
        XCTAssertEqual(viewSpy.shownError, "Invalid credentials")
    }

    func test_givenViewDidLoad_whenLoginControllerFails_thenViewShowsUnknownError() {
        let loginController = LoginControllerStub()
        self.loginController = loginController
        setUp()
        sut.viewDidLoad()
        viewSpy.stopLoadingCalled = false

        loginController.failure?(TestError.error)

        XCTAssertTrue(viewSpy.stopLoadingCalled)
        XCTAssertEqual(viewSpy.shownError, "Unknown error")
    }
}
