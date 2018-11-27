//
//  InstanceProvider.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 27/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import Foundation
import CleanKiwiCore

class InstanceProvider {

    static let shared = InstanceProvider()

    private init() { }

    enum Error: Swift.Error {
        case unableToResolve
    }

    func instance<T>(of type: T.Type) throws -> T {

        switch type {
        case is LoginViewController.Type:
            let loginPresenter = LoginPresenterImpl()
            let loginViewController = LoginViewController.make(loginPresenter: loginPresenter)
            loginPresenter.view = loginViewController
            return loginViewController as! T
        default:
            throw Error.unableToResolve
        }

    }
}
