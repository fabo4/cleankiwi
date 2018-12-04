//
//  EnvironmentConfig.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public protocol EnvironmentConfig {
    func baseUrlString() -> String
    func applicationId() -> String
}
