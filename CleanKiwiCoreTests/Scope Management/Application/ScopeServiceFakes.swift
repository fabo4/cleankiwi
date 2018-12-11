//
//  ScopeServiceFakes.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

typealias ScopeServiceDummy = ScopeServiceSpy

typealias ScopeServiceStub = ScopeServiceSpy

class ScopeServiceSpy: ScopeService {

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
}
