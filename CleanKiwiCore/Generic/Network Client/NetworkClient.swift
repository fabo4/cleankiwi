//
//  NetworkClient.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//


public typealias RequestParameters = [String: String]

public struct NetworkClientRequest {

    public enum Method {
        case post
        case get
    }

    public let method: Method
    public let parameters: [String: String]
    public let urlString: String

    public init(method: Method, parameters: RequestParameters, urlString: String) {
        self.method = method
        self.parameters = parameters
        self.urlString = urlString
    }
}


public struct NetworkClientResponse {

    public enum Body {
        case array([[String: Any]])
        case dictionary([String: Any])
    }

    public let body: Body
    public let statusCode: Int

    public init(body: Body, statusCode: Int) {
        self.body = body
        self.statusCode = statusCode
    }
}

public enum NetworkClientError: Error {
    case networkError
}

public protocol NetworkClient {
    func run(request: NetworkClientRequest) throws -> NetworkClientResponse
}
