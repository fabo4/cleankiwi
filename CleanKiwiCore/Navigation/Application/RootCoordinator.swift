//
//  RootCoordinator.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public protocol RootCoordinator { }

public class RootCoordinatorImpl: RootCoordinator {

    private let scopeController: ScopeController
    private let rootWireframe: RootWireframe

    public init(scopeController: ScopeController, rootWireframe: RootWireframe) {
        self.scopeController = scopeController
        self.rootWireframe = rootWireframe
        subscribeScope()
    }


    private func subscribeScope() {
        scopeController.subscribeUpdate { [weak self] in
            self?.scopeUpdated()
        }
    }

    private func scopeUpdated() {
        if scopeController.sessionStarted() {
            rootWireframe.showBookings()
        } else {
            rootWireframe.showLogin()
        }
    }
}
