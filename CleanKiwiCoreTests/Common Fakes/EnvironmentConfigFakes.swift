//
//  EnvironmentConfigFakes.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

typealias EnvironmentConfigDummy = EnvironmentConfigStub

class EnvironmentConfigStub: EnvironmentConfig {

    var baseUrl = ""
    var appId = ""

    func baseAuthenticationUrlString() -> String {
        return baseUrl
    }

    func baseBookingsUrlString() -> String {
        return baseUrl
    }

    func applicationId() -> String {
        return appId
    }
}
