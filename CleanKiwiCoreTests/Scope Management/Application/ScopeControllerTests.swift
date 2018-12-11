//
//  ScopeControllerTests.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import XCTest
import CleanKiwiCore

class ScopeControllerTests: XCTestCase {

    var scopeService: ScopeService = ScopeServiceDummy()

    var sut: ScopeController!

    override func setUp() {
        sut = ScopeControllerImpl(scopeService: scopeService)
    }

    func test_whenStartSessionScope_thenServiceStartsSessionScopeAndItUpdates() {
        let scopeService = ScopeServiceSpy()
        self.scopeService = scopeService
        setUp()
        var updateNotified = false
        sut.subscribeUpdate { updateNotified = true }

        sut.startSessionScope(SessionScope(session: Session(token: "token")))

        XCTAssertNotNil(scopeService.startedSessionScope)
        XCTAssertTrue(updateNotified)
    }

    func test_whenDiscardSessionScope_thenServiceDiscardsSessionScopeAndItUpdates() {
        let scopeService = ScopeServiceSpy()
        self.scopeService = scopeService
        setUp()
        var updateNotified = false
        sut.subscribeUpdate { updateNotified = true }

        sut.discardSessionScope()

        XCTAssertTrue(scopeService.discardSessionScopeCalled)
        XCTAssertTrue(updateNotified)
    }

    func test_givenServiceSessionStarted_whenGetSessionStarted_thenItsTrue() {
        let scopeService = ScopeServiceStub()
        self.scopeService = scopeService
        setUp()
        scopeService.session = true

        let sessionStarted = sut.sessionStarted()

        XCTAssertTrue(sessionStarted)
    }

    func test_givenServiceSessionNotStarted_whenGetSessionStarted_thenItsFalse() {
        let scopeService = ScopeServiceStub()
        self.scopeService = scopeService
        setUp()
        scopeService.session = false

        let sessionStarted = sut.sessionStarted()

        XCTAssertFalse(sessionStarted)
    }

}
