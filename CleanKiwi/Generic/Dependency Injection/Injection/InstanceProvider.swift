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

    let applicationContainer: Container
    var sessionContainer: Container?

    private init() {
        applicationContainer = Container()
        registerLogin(container: applicationContainer)
        registerNetworking(container: applicationContainer)
        registerConfiguration(container: applicationContainer)
        registerScopeManagement(container: applicationContainer)
    }

    func instance<T>(of type: T.Type) throws -> T {

        let container = sessionContainer ?? applicationContainer

        guard let instance = container.resolve(type) else {
            throw InstanceProvider.Error.unableToResolve(type: "\(type)")
        }

        return instance
    }

    private func registerLogin(container: Container) {
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

    private func registerScopeManagement(container: Container) {
        container.autoregister(ScopeController.self, initializer: ScopeControllerImpl.init)

        container.register(ScopeService.self) { _ in
            return InstanceProvider.shared
        }
    }

    func registerConfiguration(container: Container) {
        container.autoregister(EnvironmentConfig.self, initializer: ProductionEnvironmentConfig.init)
    }

    func registerNetworking(container: Container) {
        container.autoregister(NetworkClient.self, initializer: SynchronousNetworkClient.init)
    }
}

extension InstanceProvider: ScopeService {

    func startSessionScope(_ sessionScope: SessionScope) {
        sessionContainer = Container(parent: applicationContainer)

        sessionContainer?.register(Session.self) { _ in
            return sessionScope.session
        }
    }

    func discardSessionScope() {
        sessionContainer = nil
    }

    func sessionStarted() -> Bool {
        return sessionContainer != nil
    }
}
