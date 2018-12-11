//
//  SubscriptionController.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public protocol SubscriptionController {
    func isLoading() -> Bool
    func subscribeUpdate(_ update: @escaping () -> Void)
    func subscribeFailure(_ failure: @escaping (Error) -> Void)
}

public class SubscriptionControllerImpl: SubscriptionController {

    var update: (() -> Void)?
    var failure: ((Error) -> Void)?

    var loading = false

    public init() { }

    public func isLoading() -> Bool {
        return loading
    }

    public func subscribeUpdate(_ update: @escaping () -> Void) {
        self.update = update
    }

    public func subscribeFailure(_ failure: @escaping (Error) -> Void) {
        self.failure = failure
    }
}
