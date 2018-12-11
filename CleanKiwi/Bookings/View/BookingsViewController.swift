//
//  BookingsViewController.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 11/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import UIKit
import CleanKiwiCore

class BookingsViewController: UIViewController {

    var bookingsPresenter: BookingsPresenter!

    static func make(bookingsPresenter: BookingsPresenter) -> BookingsViewController {
        let storyboard = UIStoryboard(name: "Bookings", bundle: Bundle(for: BookingsViewController.self))

        let bookingsViewController = storyboard.instantiateViewController(withIdentifier: "BookingsViewController") as! BookingsViewController
        bookingsViewController.bookingsPresenter = bookingsPresenter
        return bookingsViewController
    }

    @IBAction func logout(_ sender: Any) {
        bookingsPresenter.logout()
    }
}
