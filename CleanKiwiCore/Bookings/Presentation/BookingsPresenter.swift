//
//  BookingsPresenter.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public protocol BookingsPresenter {
    func logout()
}

public class BookingsPresenterImpl: BookingsPresenter {

    private let scopeController: ScopeController

    public init(scopeController: ScopeController) {
        self.scopeController = scopeController
    }

    public func logout() {
        scopeController.discardSessionScope()
    }
}
