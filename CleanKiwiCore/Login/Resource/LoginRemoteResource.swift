//
//  LoginRemoteResource.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public class LoginRemoteResource: LoginResource {

    let networkClient: NetworkClient
    let environmentConfig: EnvironmentConfig

    public init(networkClient: NetworkClient, environmentConfig: EnvironmentConfig) {
        self.networkClient = networkClient
        self.environmentConfig = environmentConfig
    }

    public func login(request: LoginRequest) throws -> LoginResponse {

        let parameters = requestParameters(from: request)
        let networkRequest = NetworkClientRequest(method: .post, parameters: parameters, urlString: url())

        let networkResponse = try networkClient.run(request: networkRequest)

        return try handleResponse(networkResponse)
    }

    private func url() -> String {
        return environmentConfig.baseAuthenticationUrlString() + "/user.login?app_id=" + environmentConfig.applicationId()
    }

    private func requestParameters(from request: LoginRequest) -> [String: String] {
        return ["login": request.username, "password": request.password]
    }

    private func handleResponse(_ networkResponse: NetworkClientResponse) throws -> LoginResponse {

        switch networkResponse.body {
        case .dictionary(let dictionary):
            try parseErrorResponse(dictionary: dictionary)
            return try parseResponse(dictionary: dictionary)
        case .array:
            throw LoginResourceError.incorrectResponse
        }
    }

    private func parseErrorResponse(dictionary: [String: Any]) throws {
        if let errorCode = dictionary["error_code"] as? String {
            switch errorCode {
            case "INVALID_LOGIN":
                throw LoginControllerError.invalidCredentials
            default:
                throw LoginControllerError.unknown
            }
        }
    }

    private func parseResponse(dictionary: [String: Any]) throws -> LoginResponse {
        guard let token = dictionary["token"] as? String else {
            throw LoginResourceError.incorrectResponse
        }

        guard let userId = dictionary["user_id"] as? String else {
            throw LoginResourceError.incorrectResponse
        }

        return LoginResponse(token: token, userId: userId)
    }
}
