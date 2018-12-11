//
//  UserResourceAuthenticatorTests.swift
//  CleanKiwiCoreTests
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import XCTest
import CleanKiwiCore

class UserResourceAuthenticatorTests: XCTestCase {

    var session: Session = Session(token: "")

    var sut: ResourceAuthenticator!

    override func setUp() {
        sut = UserResourceAuthenticator(session: session)
    }

    func test_givenSession_whenGetAuthentication_thenAuthenticationIsCorrect() {
        let session = Session(token: "auth_token")
        self.session = session
        setUp()

        let authentication = sut.authentication()

        XCTAssertEqual(authentication, "token=auth_token")
    }
}
