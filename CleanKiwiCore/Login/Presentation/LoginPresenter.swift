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

    public init() { }

    public func viewDidLoad() {

    }

    public func login(username: String, password: String) {

    }
}
