//
//  LoginViewController.swift
//  Weinbergapp
//
//  Created by Nina Kirilmaz on 08.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func passwordVisibilityToggled(_ sender: UISwitch) {
        password.isSecureTextEntry = !sender.isOn
    }

    @IBAction func login(_ sender: Any) {
        if username.text == "" && password.text == "" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "Controller")
                as? UITabBarController {
                self.present(controller, animated: true)
            }
        } else {

            let alert = UIAlertController(
                title: "Login fehlgeschlagen",
                message: "Ungültige Zugangsdaten. Bitte versuchen Sie es erneut",
                preferredStyle: UIAlertControllerStyle.alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style {
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true)
        }
    }
}
