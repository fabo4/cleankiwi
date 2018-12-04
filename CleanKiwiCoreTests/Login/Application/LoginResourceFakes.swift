//
//  LoginResourceFakes.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

typealias LoginResourceDummy = LoginResourceSpy

class LoginResourceFailingStub: LoginResource {

    func login(request: LoginRequest) throws -> LoginResponse {
            throw TestError.error
    }
}

class LoginResourceSuccessStub: LoginResource {

    func login(request: LoginRequest) throws -> LoginResponse {
        return LoginResponse()
    }
}

class LoginResourceSpy: LoginResource {

    var request: LoginRequest?
    var response: LoginResponse?

    func login(request: LoginRequest) throws -> LoginResponse {
        self.request = request

        guard let response = self.response else {
            throw TestError.error
        }

        return response
    }
}
