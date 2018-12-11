//
//  ResourceAuthenticatorFakes.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

typealias ResourceAuthenticatorDummy = ResourceAuthenticatorSpy

typealias ResourceAuthenticatorStub = ResourceAuthenticatorSpy

class ResourceAuthenticatorSpy: ResourceAuthenticator {
    
    var auth = ""

    func authentication() -> String {
        return auth
    }
}
