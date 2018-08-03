//
//  LoginViewController.swift
//  Weinbergapp
//
//  Created by Nina Kirilmaz on 08.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class LoginViewController: UIViewController, UITextFieldDelegate {

    static let kUsername = "user"
    static let kPassword = "weinberg"

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        username.delegate = self
        password.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        login(textField)
        return true
    }

    @IBAction func passwordVisibilityToggled(_ sender: UISwitch) {
        password.isSecureTextEntry = !sender.isOn
    }

    @IBAction func login(_ sender: Any) {
        guard username.text == LoginViewController.kUsername &&
            password.text == LoginViewController.kPassword else {
            LoginDialogs.presentLoginFailed(controller: self)
            return
        }

        do {
            let realm = try Realm()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            if let controller = storyboard.instantiateViewController(withIdentifier: "Main")
                as? MainViewController {
                controller.realm = realm

                password.text = ""
                self.present(controller, animated: true)
            }
        } catch let error as NSError {
            LoginDialogs.presentDatabaseError(error, controller: self)
            return
        }
    }
}
