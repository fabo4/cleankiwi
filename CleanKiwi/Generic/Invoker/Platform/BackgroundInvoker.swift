//
//  BackgroundInvoker.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import Foundation
import CleanKiwiCore

class BackgroundLoginInvoker: LoginInvoker {

    func invoke(action: @escaping () throws -> LoginResponse, completion: @escaping (Result<LoginResponse>) -> Void) {

        DispatchQueue.global().async {

            let result: Result<LoginResponse>
            do {
                let response = try action()
                result = Result.success(response: response)
            } catch {
                result = Result.failure(error: error)
            }

            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
