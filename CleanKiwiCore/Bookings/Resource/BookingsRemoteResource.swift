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
        return []
    }

    private func url() -> String {
        return environmentConfig.baseBookingsUrlString() + "/users/self/bookings?v=2&" + resourceAuthenticator.authentication()
    }
}
