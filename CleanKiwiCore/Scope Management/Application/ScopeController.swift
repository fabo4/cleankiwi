//
//  ScopeController.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public class SessionScope: Equatable {

    public let session: Session

    public init(session: Session) {
        self.session = session
    }

    public static func == (lhs: SessionScope, rhs: SessionScope) -> Bool {
        return lhs.session == rhs.session
    }
}

public protocol ScopeController: SubscriptionController {
    func startSessionScope(_ sessionScope: SessionScope)
    func discardSessionScope()
    func sessionStarted() -> Bool
}

public class ScopeControllerImpl: SubscriptionControllerImpl, ScopeController {

    private let scopeService: ScopeService

    public init(scopeService: ScopeService) {
        self.scopeService = scopeService
    }

    public func startSessionScope(_ sessionScope: SessionScope) {
        scopeService.startSessionScope(sessionScope)
        update?()
    }

    public func discardSessionScope() {
        scopeService.discardSessionScope()
        update?()
    }

    public func sessionStarted() -> Bool {
        return scopeService.sessionStarted()
    }
}
