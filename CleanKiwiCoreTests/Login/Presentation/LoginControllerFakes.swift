//
//  LoginControllerFakes.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 27/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

typealias LoginControllerDummy = LoginControllerSpy

typealias LoginControllerStub = LoginControllerSpy

class LoginControllerSpy: LoginController {

    var loading = false
    var update: (() -> Void)?
    var failure: ((Error) -> Void)?
    var username: String?
    var password: String?

    func isLoading() -> Bool {
        return loading
    }

    func subscribeUpdate(_ update: @escaping () -> Void) {
        self.update = update
    }

    func subscribeFailure(_ failure: @escaping (Error) -> Void) {
        self.failure = failure
    }

    func login(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
