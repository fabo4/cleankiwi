//
//  AppDelegate.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 26/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let splashViewController = SplashViewController.make()

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window

        window.rootViewController = splashViewController

        return true
    }
}

