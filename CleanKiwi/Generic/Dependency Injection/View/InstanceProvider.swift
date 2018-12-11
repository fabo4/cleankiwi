//
//  InstanceProvider.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

enum InstanceProviderError: Swift.Error {
    case unableToResolve(type: String)
}

protocol InstanceProvider {
    func instance<T>(of type: T.Type) throws -> T
}
