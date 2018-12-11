//
//  BookingsRemoteResource.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public class BookingsRemoteResource: BookingsResource {

    let networkClient: NetworkClient
    let environmentConfig: EnvironmentConfig
    let resourceAuthenticator: ResourceAuthenticator

    public init(networkClient: NetworkClient, environmentConfig: EnvironmentConfig, resourceAuthenticator: ResourceAuthenticator) {
        self.networkClient = networkClient
        self.environmentConfig = environmentConfig
        self.resourceAuthenticator = resourceAuthenticator
    }

    public func bookings() throws -> [Booking] {

        let networkRequest = NetworkClientRequest(method: .get, parameters: [:], urlString: url())

        let networkResponse = try networkClient.run(request: networkRequest)
        return try handleResponse(networkResponse)
    }

    private func url() -> String {
        return environmentConfig.baseBookingsUrlString() + "/users/self/bookings?v=2&" + resourceAuthenticator.authentication()
    }

    private func handleResponse(_ networkResponse: NetworkClientResponse) throws -> [Booking] {

        switch networkResponse.body {
        case .array(let array):
            return try parseResponse(array: array)
        case .dictionary:
            throw ResourceError.incorrectResponse
        }
    }

    private func parseResponse(array: [[String: Any]]) throws -> [Booking] {
        return try array.compactMap(parseResponse)
    }

    private func parseResponse(dictionary: [String: Any]) throws -> Booking? {
        guard let bid = dictionary["bid"] as? String else {
            return nil
        }

        return Booking(bid: bid)
    }
}
