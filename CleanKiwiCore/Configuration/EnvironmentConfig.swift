//
//  EnvironmentConfig.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public protocol EnvironmentConfig {
    func baseAuthenticationUrlString() -> String
    func baseBookingsUrlString() -> String
    func applicationId() -> String
}
