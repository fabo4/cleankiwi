//
//  LoginPresenter.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 27/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import Foundation

public protocol LoginPresenter {
    func viewDidLoad()
    func login(username: String, password: String)
}

public class LoginPresenterImpl: LoginPresenter {

    private let loginController: LoginController

    public weak var view: LoginView?

    public init(loginController: LoginController) {
        self.loginController = loginController
    }

    public func viewDidLoad() {
        setupView()
        subscribeLoginController()
    }

    private func setupView() {
        let localization = LoginLocalization(usernamePlaceholder: "Email", passwordPlaceholder: "Password", loginButtonLabel: "Login")
        view?.localize(localization: localization)
        view?.show(error: "")
        view?.stopLoading()
    }

    private func subscribeLoginController() {
        loginController.subscribeUpdate { [weak self] in
            self?.updateLoading()
        }

        loginController.subscribeFailure { [weak self] error in
            self?.handle(error: error)
            self?.updateLoading()
        }
    }

    private func handle(error: Error) {
        if let loginError = error as? LoginControllerError, loginError == .invalidCredentials {
            view?.show(error: "Invalid credentials")
        } else {
            view?.show(error: "Unknown error")
        }
    }

    private func updateLoading() {
        loginController.isLoading() ? view?.startLoading() : view?.stopLoading()
    }

    public func login(username: String, password: String) {
        view?.show(error: "")
        let cleanUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        loginController.login(username: cleanUsername.lowercased(), password: password)
    }
}
