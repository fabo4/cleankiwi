//
//  ScopeControllerFakes.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

typealias ScopeControllerDummy = ScopeControllerSpy

typealias ScopeControllerStub = ScopeControllerSpy

class ScopeControllerSpy: ScopeController {

    var loading = false
    var update: (() -> Void)?
    var failure: ((Error) -> Void)?

    var startedSessionScope: SessionScope?
    var discardSessionScopeCalled = false
    var session = false

    func startSessionScope(_ sessionScope: SessionScope) {
        self.startedSessionScope = sessionScope
    }

    func discardSessionScope() {
        discardSessionScopeCalled = true
    }

    func sessionStarted() -> Bool {
        return session
    }

    // TODO: - Make controller tests DRY and extract subscribtion to SubscribtionControllerFakes
    func isLoading() -> Bool {
        return loading
    }

    func subscribeUpdate(_ update: @escaping () -> Void) {
        self.update = update
    }

    func subscribeFailure(_ failure: @escaping (Error) -> Void) {
        self.failure = failure
    }
}
