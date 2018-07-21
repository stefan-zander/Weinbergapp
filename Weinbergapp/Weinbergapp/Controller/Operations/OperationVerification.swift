//
//  OperationVerification.swift
//  Weinbergapp
//
//  Created by VM on 22.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class OperationVerification {

    public static func verify(field: UITextField, _ controller: UIViewController) -> String? {
        guard let field = field.text, !field.isEmpty else {
            let alert = UIAlertController(title: "Feld nicht angegeben",
                                          message: "Ein Feld muss angegeben werden.",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))

            controller.present(alert, animated: true)
            return nil
        }

        return field
    }

    public static func verify(user: UITextField, _ controller: UIViewController) -> String? {
        guard let user = user.text, !user.isEmpty else {
            let alert = UIAlertController(title: "Benutzer nicht angegeben",
                                          message: "Ein Benutzer muss angegeben werden.",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))

            controller.present(alert, animated: true)
            return nil
        }

        return user
    }

    public static func verify(workingHours: UITextField, _ controller: UIViewController) -> Double? {
        guard let workingHoursText = workingHours.text, !workingHoursText.isEmpty else {
            let alert = UIAlertController(title: "Arbeitsstunden nicht angegeben",
                                          message: "Die Arbeitsstunden müssen angegeben werden.",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))

            controller.present(alert, animated: true)
            return nil
        }

        guard let workingHours = Double(workingHoursText) else {
            let alert = UIAlertController(title: "Arbeitsstunden ist keine Zahl",
                                          message: "Bei der Angabe von Arbeitsstunden sind nur Zahlen erlaubt.",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))

            controller.present(alert, animated: true)
            return nil
        }

        return workingHours
    }

    public static func verify(appliedAmount: UITextField, _ controller: UIViewController) -> Double? {
        guard let appliedAmountText = appliedAmount.text, !appliedAmountText.isEmpty else {
            let alert = UIAlertController(title: "Ausgegebene Menge nicht angegeben",
                                          message: "Die ausgegebene Menge muss angegeben werden.",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))

            controller.present(alert, animated: true)
            return nil
        }

        guard let appliedAmount = Double(appliedAmountText) else {
            let alert = UIAlertController(title: "Ausgegebene Menge ist keine Zahl",
                                          message: "Bei der Angabe von der ausgegebenen Menge sind nur Zahlen erlaubt.",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))

            controller.present(alert, animated: true)
            return nil
        }

        return appliedAmount
    }

}
