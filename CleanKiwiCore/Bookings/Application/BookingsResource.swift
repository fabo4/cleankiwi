//
//  BookingsResource.swift
//  CleanKiwiCore
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

public protocol BookingsResource {
    func bookings() throws -> [Booking]
}
