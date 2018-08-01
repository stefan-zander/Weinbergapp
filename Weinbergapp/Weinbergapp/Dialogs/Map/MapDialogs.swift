//
//  MapDialogs.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 24.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class MapDialogs {

    static func presentLocationError(_ error: Error, controller: UIViewController) {
        let alert = UIAlertController(title: "Standort konnte nicht ermittelt werden.",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        controller.present(alert, animated: true)
    }

    static func presentInsufficientPointsWarning(controller: MapViewController,
                                                 onCancel: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: "Nicht genügend Punkte eingezeichnet",
                                      message: "Um eine Fläche aufzuspannen werden mindestens drei Punkte benötigt.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Weitere Punkte einzeichnen", style: .default))
        alert.addAction(UIAlertAction(title: "Vorgang abbrechen", style: .cancel, handler: onCancel))

        controller.present(alert, animated: true)
    }

    static func presentDatabaseAddError(_ error: Error, controller: UIViewController) {
        let alert = UIAlertController(title: "Feld konnte nicht hinzugefügt werden.",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        controller.present(alert, animated: true)
    }

    static func presentDatabaseUpdateError(_ error: Error, controller: UIViewController) {
        let alert = UIAlertController(title: "Feld konnte nicht geändert werden.",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        controller.present(alert, animated: true)
    }

    static func presentDeletionConfirmation(controller: AddFieldViewController, field: MapField,
                                            onConfirmation: ((UIAlertAction) -> Swift.Void)? = nil) {
        let message: String
        let useCount = field.useCount
        
        if useCount > 0 {
            message = "Möchten Sie das Feld \"\(field.name)\" und \(useCount) dazugehörige Operation(en) wirklich " +
                      "löschen?"
        } else {
            message = "Möchten Sie das Feld \"\(field.name)\" wirklich löschen?"
        }
        
        let alert = UIAlertController(title: "Löschvorgang bestätigen",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ja, \"\(field.name)\" löschen",
                                      style: .default,
                                      handler: onConfirmation))
            
        alert.addAction(UIAlertAction(title: "Nein, \"\(field.name)\" beibehalten",
                                      style: .cancel))

        controller.present(alert, animated: true)
    }

    static func presentDatabaseDeletionError(_ error: Error, controller: UIViewController) {
        let alert = UIAlertController(title: "Feld konnte nicht gelöscht werden.",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        controller.present(alert, animated: true)
    }
    
    static func verifyOrPresent(name: UITextField, _ controller: UIViewController) -> String? {
        guard let name = name.text, !name.isEmpty else {
            let alert = UIAlertController(title: "Name nicht angegeben",
                                          message: "Ein Name für das Feld muss angegeben werden.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            controller.present(alert, animated: true)
            return nil
        }
        
        return name
    }
    
    static func verifyOrPresent(vineVariety: UITextField, _ controller: UIViewController) -> String? {
        guard let vineVariety = vineVariety.text, !vineVariety.isEmpty else {
            let alert = UIAlertController(title: "Reben Sorte nicht angegeben",
                                          message: "Eine Reben Sorte muss für das Feld angegeben werden.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            controller.present(alert, animated: true)
            return nil
        }
        
        return vineVariety
    }
}
