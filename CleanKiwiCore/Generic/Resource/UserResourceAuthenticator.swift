//
//  UserResourceAuthenticator.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public class UserResourceAuthenticator: ResourceAuthenticator {

    private let session: Session

    public init(session: Session) {
        self.session = session
    }

    public func authentication() -> String {
        return "token=" + session.token
    }
}
