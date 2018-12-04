//
//  LoginResource.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public struct LoginRequest {
    public let username: String
    public let password: String
}

public struct LoginResponse {

    public init() { }
}

public protocol LoginResource {

    func login(request: LoginRequest) throws -> LoginResponse
}
