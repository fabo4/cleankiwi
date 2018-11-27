//
//  LoginViewFakes.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 27/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

class LoginViewSpy: LoginView {

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
