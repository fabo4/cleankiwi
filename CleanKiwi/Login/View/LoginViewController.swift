//
//  LoginViewController.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 26/11/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import UIKit
import CleanKiwiCore

class LoginViewController: UIViewController, LoginView {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!

    private var loginPresenter: LoginPresenter!

    static func make(loginPresenter: LoginPresenter) -> LoginViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle(for: LoginViewController.self))

        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginViewController.loginPresenter = loginPresenter
        return loginViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginPresenter.viewDidLoad()
    }

    @IBAction func login(_ sender: Any) {
        loginPresenter.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    func localize(localization: LoginLocalization) {
        usernameTextField.placeholder = localization.usernamePlaceholder
        passwordTextField.placeholder = localization.passwordPlaceholder
        loginButton.setTitle(localization.loginButtonLabel, for: .normal)
    }

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }

    func show(error: String) {
        errorLabel.text = error
    }
}

