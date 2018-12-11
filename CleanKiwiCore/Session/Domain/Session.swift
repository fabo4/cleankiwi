//
//  Session.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public class Session: Equatable {

    public let token: String

    public init(token: String) {
        self.token = token
    }

    public static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.token == rhs.token
    }
}
