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
}

public protocol LoginController {

    func isLoading() -> Bool
    func subscribeUpdate(_ update: @escaping () -> Void)
    func subscribeFailure(_ failure: @escaping (Error) -> Void)
    func login(username: String, password: String)
}
