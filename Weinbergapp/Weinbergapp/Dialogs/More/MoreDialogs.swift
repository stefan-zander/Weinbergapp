//
//  MoreDialogs.swift
//  Weinbergapp
//
//  Created by VM on 02.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class MoreDialogs {

    static func presentAddError(_ error: Error, controller: UIViewController) {
        let alert = UIAlertController(title: "Betrieb konnte nicht hinzugefügt werden.",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        controller.present(alert, animated: true)
    }
}
