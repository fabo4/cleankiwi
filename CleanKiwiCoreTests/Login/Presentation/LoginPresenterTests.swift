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

    private var sut: LoginPresenterImpl!
    private var viewSpy: LoginViewSpy!

    override func setUp() {
        super.setUp()
        sut = LoginPresenterImpl()
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
}

private class LoginViewSpy: LoginView {

    var localization: LoginLocalization?
    var startLoadingCalled = false
    var stopLoadingCalled = false
    var shownError: String?

    func localize(localization: LoginLocalization) {
        self.localization = localization
    }

    func startLoading() {
        self.startLoadingCalled = true
    }

    func stopLoading() {
        self.stopLoadingCalled = true
    }

    func show(error: String) {
        self.shownError = error
    }
}
