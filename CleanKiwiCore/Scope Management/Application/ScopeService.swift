//
//  ScopeService.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public protocol ScopeService {
    func startSessionScope(_ sessionScope: SessionScope)
    func discardSessionScope()
    func sessionStarted() -> Bool
}
