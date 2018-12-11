//
//  RootCoordinatorTests.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import XCTest
import CleanKiwiCore

class RootCoordinatorTests: XCTestCase {

    var scopeController: ScopeController = ScopeControllerDummy()
    var rootWireframe: RootWireframe = RootWireframeDummy()

    var sut: RootCoordinator!

    override func setUp() {
        sut = RootCoordinatorImpl(scopeController: scopeController, rootWireframe: rootWireframe)
    }

    func test_givenSessionStared_whenScopeControllerNotifies_thenWireframeShowsBookings() {
        let scopeController = ScopeControllerStub()
        self.scopeController = scopeController
        let rootWireframe = RootWireframeSpy()
        self.rootWireframe = rootWireframe
        setUp()
        scopeController.session = true

        scopeController.update?()

        XCTAssertTrue(rootWireframe.showBookingsCalled)
    }

    func test_givenSessionEnded_whenScopeControllerNotifies_thenWireframeShowsLogin() {
        let scopeController = ScopeControllerStub()
        self.scopeController = scopeController
        let rootWireframe = RootWireframeSpy()
        self.rootWireframe = rootWireframe
        setUp()
        scopeController.session = false

        scopeController.update?()

        XCTAssertTrue(rootWireframe.showLoginCalled)
    }

}
