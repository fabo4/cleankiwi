//
//  NetworkClientFakes.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

typealias NetworkClientDummy = NetworkClientSpy

typealias NetworkClientStub = NetworkClientSpy

class NetworkClientSpy: NetworkClient {

    var request: NetworkClientRequest?
    var response: NetworkClientResponse?

    func run(request: NetworkClientRequest) throws -> NetworkClientResponse {
        self.request = request

        guard let response = self.response else {
            throw TestError.error
        }

        return response
    }
}
