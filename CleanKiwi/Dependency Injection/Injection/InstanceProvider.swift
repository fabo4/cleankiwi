//
//  InstanceProvider.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 27/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import Foundation
import CleanKiwiCore
import Swinject
import SwinjectAutoregistration

class InstanceProvider {

    enum Error: Swift.Error {
        case unableToResolve(type: String)
    }

    static let shared = InstanceProvider()

    let container = Container()

    private init() {
        registerLogin()
    }

    func instance<T>(of type: T.Type) throws -> T {
        guard let instance = container.resolve(type) else {
            throw InstanceProvider.Error.unableToResolve(type: "\(type)")
        }

        return instance
    }

    private func registerLogin() {
        container.autoregister(LoginViewController.self, initializer: LoginViewController.make).implements(LoginView.self)

        container.autoregister(LoginPresenter.self, initializer: LoginPresenterImpl.init).initCompleted { resolver, presenter in
            if let loginPresenter = presenter as? LoginPresenterImpl {
                loginPresenter.view = resolver.resolve(LoginView.self)
            }
        }

        container.autoregister(LoginController.self, initializer: LoginControllerImpl.init)

        container.autoregister(LoginResource.self, initializer: LoginRemoteResource.init)

        container.autoregister(LoginInvoker.self, initializer: BackgroundLoginInvoker.init)
    }
}
