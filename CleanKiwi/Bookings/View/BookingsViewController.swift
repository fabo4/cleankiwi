//
//  BookingsViewController.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import UIKit

class BookingsViewController: UIViewController {

    static func make() -> BookingsViewController {
        let storyboard = UIStoryboard(name: "Bookings", bundle: Bundle(for: BookingsViewController.self))

        let bookingsViewController = storyboard.instantiateViewController(withIdentifier: "BookingsViewController") as! BookingsViewController
        return bookingsViewController
    }
}
