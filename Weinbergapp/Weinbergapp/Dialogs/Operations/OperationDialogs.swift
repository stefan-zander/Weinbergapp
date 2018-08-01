//
//  OperationDialogs.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 27.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class OperationDialogs {
    
    static func presentNoFields(controller: UIViewController) {
        let alert = UIAlertController(title: "Keine Felder vorhanden",
                                      message: "Sie müssen erst Felder auf der Karte einzeichnen bevor Sie " +
                                               "Operationen anlegen können.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        controller.present(alert, animated: true)
    }
    
    static func presentAddError(_ error: NSError, controller: UIViewController) {
        let alert = UIAlertController(title: "Operation konnte nicht hinzugefügt werden",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        controller.present(alert, animated: true)
    }

    static func presentSaveError(_ error: NSError, controller: UIViewController) {
        let alert = UIAlertController(title: "Veränderungen konnten nicht gespeichert werden",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        controller.present(alert, animated: true)
    }

    static func presentDeletionError(_ error: NSError, controller: UIViewController) {
        let alert = UIAlertController(title: "Fehler beim Löschen der Operation",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        controller.present(alert, animated: true)
    }
}
