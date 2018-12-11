//
//  RootWireframeFakes.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

typealias RootWireframeDummy = RootWireframeSpy

typealias RootWireframeStub = RootWireframeSpy

class RootWireframeSpy: RootWireframe {

    var showBookingsCalled = false
    var showLoginCalled = false

    func showBookings() {
        showBookingsCalled = true
    }

    func showLogin() {
        showLoginCalled = true
    }
}
