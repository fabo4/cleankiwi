//
//  ProductionEnvironmentConfig.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import CleanKiwiCore

class ProductionEnvironmentConfig: EnvironmentConfig {
    func baseUrlString() -> String {
        return "https://auth.skypicker.com/v1"
    }

    func applicationId() -> String {
        return "Tg87gI6-lsP5qi30T1oPNR"
    }
}
