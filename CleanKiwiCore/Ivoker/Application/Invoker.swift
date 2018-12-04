//
//  Invoker.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public enum Result<Response> {
    case success(response: Response)
    case failure(error: Error)
}

public protocol LoginInvoker {
    func invoke(action: @escaping () throws -> LoginResponse, completion: @escaping (Result<LoginResponse>) -> Void)
}
