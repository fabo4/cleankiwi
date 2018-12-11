//
//  BookingsPresenterTests.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import XCTest
import CleanKiwiCore

class BookingsPresenterTests: XCTestCase {

    var scopeController: ScopeController = ScopeControllerDummy()

    var sut: BookingsPresenter!

    override func setUp() {
        sut = BookingsPresenterImpl(scopeController: scopeController)
    }

    func test_whenLogout_thenSessionScopeIsDiscarded() {
        let scopeController = ScopeControllerSpy()
        self.scopeController = scopeController
        setUp()

        sut.logout()

        XCTAssertTrue(scopeController.discardSessionScopeCalled)
    }
}
