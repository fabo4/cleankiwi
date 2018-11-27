//
//  LoginView.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 27/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import Foundation

public struct LoginLocalization {
    public let usernamePlaceholder: String
    public let passwordPlaceholder: String
    public let loginButtonLabel: String
}

public protocol LoginView {

    func localize(localization: LoginLocalization)
    func startLoading()
    func stopLoading()
    func show(error: String)
}
