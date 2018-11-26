//
//  SplashViewController.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 26/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    static func make() -> SplashViewController {
        let storyboard = UIStoryboard(name: "Splash", bundle: Bundle(for: SplashViewController.self))
        return storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
    }
}

