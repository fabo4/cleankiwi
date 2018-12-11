//
//  RootWireframeImpl.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import UIKit
import CleanKiwiCore

class RootWireframeImpl: RootWireframe {

    private let window: UIWindow
    private let instanceProvider: InstanceProvider

    init(window: UIWindow, instanceProvider: InstanceProvider) {
        self.window = window
        self.instanceProvider = instanceProvider
    }

    func showBookings() {
        let bookingsViewController = try! instanceProvider.instance(of: BookingsViewController.self)
        window.rootViewController = bookingsViewController
    }

    func showLogin() {
        let loginViewController = try! instanceProvider.instance(of: LoginViewController.self)
        window.rootViewController = loginViewController
    }
}
