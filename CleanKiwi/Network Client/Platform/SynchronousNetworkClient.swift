//
//  SynchronousNetworkClient.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import Foundation
import CleanKiwiCore

class SynchronousNetworkClient: NetworkClient {

    func run(request: NetworkClientRequest) throws -> NetworkClientResponse {
        throw LoginControllerError.invalidCredentials
    }
}
