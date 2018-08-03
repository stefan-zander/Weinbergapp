//
//  LoginDialogs.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 31.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class LoginDialogs {

    static func presentLoginFailed(controller: LoginViewController) {
        let alert = UIAlertController(
            title: "Login fehlgeschlagen",
            message: "Ungültige Zugangsdaten. Bitte versuchen Sie es erneut.",
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        controller.present(alert, animated: true)
    }

    static func presentDatabaseError(_ error: NSError, controller: LoginViewController) {
        let alert = UIAlertController(
            title: "Datenbankzugriff fehlgeschlagen",
            message: "Die Verbindung zur Datenbank konnte nicht hergestellt werden. Bitte versuchen Sie es erneut.",
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        controller.present(alert, animated: true)
    }
}
