//
//  LoginController.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 27/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import Foundation

public enum LoginControllerError: Error {
    case invalidCredentials
    case unknown
}

public protocol LoginController: SubscriptionController {
    func login(username: String, password: String)
}

public class LoginControllerImpl: SubscriptionControllerImpl, LoginController {

    let invoker: LoginInvoker
    let loginResource: LoginResource
    let scopeController: ScopeController

    public init(invoker: LoginInvoker, loginResource: LoginResource, scopeController: ScopeController) {
        self.invoker = invoker
        self.loginResource = loginResource
        self.scopeController = scopeController
    }

    public func login(username: String, password: String) {
        loading = true
        update?()
        invoker.invoke(action: {
            return try self.loginResource.login(request: LoginRequest(username: username, password: password))
        }, completion: { [weak self] result in
            self?.loading = false
            switch result {
            case .failure(let error):
                self?.failure?(error)
            case .success(let response):
                self?.scopeController.startSessionScope(SessionScope(session: Session(token: response.token)))
                self?.update?()
            }
        })
    }
}


