//
//  InvokerFakes.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

typealias LoginInvokerDummy = LoginInvokerSpy

typealias LoginInvokerStub = LoginInvokerSpy

class LoginInvokerSpy: LoginInvoker {

    var action: (() throws -> LoginResponse)?
    var completion: ((Result<LoginResponse>) -> Void)?

    func invoke(action: @escaping (() throws -> LoginResponse), completion: @escaping ((Result<LoginResponse>) -> Void)) {
        self.action = action
        self.completion = completion
    }
}
