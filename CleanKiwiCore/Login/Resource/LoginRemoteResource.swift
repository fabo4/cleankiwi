//
//  LoginRemoteResource.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public class LoginRemoteResource: LoginResource {

    public init() { }

    public func login(request: LoginRequest) throws -> LoginResponse {
        throw LoginControllerError.invalidCredentials
    }
}
