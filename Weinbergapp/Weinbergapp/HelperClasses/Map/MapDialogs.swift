//
//  MapDialogs.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 24.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class MapDialogs {

    static func presentLocationUnavailable(controller: UIViewController, error: Error) {
        let alert = UIAlertController(title: "Standort konnte nicht ermittelt werden.",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        controller.present(alert, animated: true)
    }
    
    static func presentInsufficientPointsWarning(controller: UIViewController,
                                                 onCancel: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: "Nicht genügend Punkte eingezeichnet",
                                      message: "Um eine Fläche aufzuspannen werden mindestens drei Punkte benötigt.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Weitere Punkte einzeichnen", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Vorgang abbrechen", style: .cancel, handler: onCancel))
        
        controller.present(alert, animated: true)
    }
    
    static func presentLoadFailed(error: NSError, controller: UIViewController) {
        let alert = UIAlertController(title: "Fehler beim Laden der Flächen",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        
        controller.present(alert, animated: true)
    }
    
    static func presentAddToDatabaseFailed(controller: UIViewController, error: Error) {
        let alert = UIAlertController(title: "Feld konnte nicht hinzugefügt werden.",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        controller.present(alert, animated: true)
    }
    
    static func presentUpdateInDatabaseFailed(controller: UIViewController, error: Error) {
        let alert = UIAlertController(title: "Feld konnte nicht geändert werden.",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        controller.present(alert, animated: true)
    }
    
    static func presentFieldDeletionConfirmation(controller: UIViewController,
                                                 fieldName: String,
                                                 onConfirmation: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "Löschen bestätigen",
                                      message: "Möchten Sie das Feld \"\(fieldName)\" wirklich löschen?",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ja, \"\(fieldName)\" löschen", style: .default, handler: onConfirmation))
        alert.addAction(UIAlertAction(title: "Nein, \"\(fieldName)\" beibehalten", style: .default, handler: nil))
        
        controller.present(alert, animated: true)
    }
    
    static func presentDeletionInDatabaseFailed(controller: UIViewController, error: Error) {
        let alert = UIAlertController(title: "Feld konnte nicht gelöscht werden.",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        controller.present(alert, animated: true)
    }
}
