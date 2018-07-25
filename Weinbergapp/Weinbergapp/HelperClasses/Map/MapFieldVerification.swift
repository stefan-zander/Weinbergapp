//
//  MapFieldVerification.swift
//  Weinbergapp
//
//  Created by VM on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

public class MapFieldVerification {

    public static func verify(name: UITextField, _ controller: UIViewController) -> String? {
        guard let name = name.text, !name.isEmpty else {
            let alert = UIAlertController(title: "Name nicht angegeben",
                                          message: "Ein Name für das Feld muss angegeben werden.",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))

            controller.present(alert, animated: true)
            return nil
        }

        return name
    }

    public static func verify(vineVariety: UITextField, _ controller: UIViewController) -> String? {
        guard let vineVariety = vineVariety.text, !vineVariety.isEmpty else {
            let alert = UIAlertController(title: "Reben Sorte nicht angegeben",
                                          message: "Eine Reben Sorte muss für das Feld angegeben werden.",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))

            controller.present(alert, animated: true)
            return nil
        }

        return vineVariety
    }
}