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

public protocol LoginController {

    func isLoading() -> Bool
    func subscribeUpdate(_ update: @escaping () -> Void)
    func subscribeFailure(_ failure: @escaping (Error) -> Void)
    func login(username: String, password: String)
}

public class LoginControllerImpl: LoginController {

    let invoker: LoginInvoker
    let loginResource: LoginResource

    var update: (() -> Void)?
    var failure: ((Error) -> Void)?

    var loading = false

    public init(invoker: LoginInvoker, loginResource: LoginResource) {
        self.invoker = invoker
        self.loginResource = loginResource
    }
    
    public func isLoading() -> Bool {
        return loading
    }

    public func subscribeUpdate(_ update: @escaping () -> Void) {
        self.update = update
    }

    public func subscribeFailure(_ failure: @escaping (Error) -> Void) {
        self.failure = failure
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
            case .success:
                self?.update?()
            }
        })
    }
}


