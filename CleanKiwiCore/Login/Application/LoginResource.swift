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

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

public struct LoginResponse {

    public let token: String
    public let userId: String

    public init(token: String, userId: String) {
        self.token = token
        self.userId = userId
    }
}



public protocol LoginResource {

    func login(request: LoginRequest) throws -> LoginResponse
}
