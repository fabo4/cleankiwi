//
//  SubscriptionControllerTests.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import XCTest
import CleanKiwiCore

class SubscriptionControllerTests: XCTestCase {

    var sut: SubscriptionController!

    override func setUp() {
        sut = SubscriptionControllerImpl()
    }

    func test_whenCreate_thenIsNotLoading() {
        XCTAssertFalse(sut.isLoading())
    }
}
