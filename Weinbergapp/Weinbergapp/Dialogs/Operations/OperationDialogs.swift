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
    
    static func verifyOrPresent(user: UITextField, _ controller: UIViewController) -> Bool {
        guard let user = user.text, !user.isEmpty else {
            let alert = UIAlertController(title: "Benutzer nicht angegeben",
                                          message: "Ein Benutzer muss angegeben werden.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            controller.present(alert, animated: true)
            return false
        }
        
        return true
    }
    
    static func verifyOrPresent(workingHours: UITextField, _ controller: UIViewController) -> Bool {
        guard let workingHoursText = workingHours.text, !workingHoursText.isEmpty else {
            let alert = UIAlertController(title: "Arbeitsstunden nicht angegeben",
                                          message: "Die Arbeitsstunden müssen angegeben werden.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            controller.present(alert, animated: true)
            return false
        }
        
        guard Double(workingHoursText) != nil else {
            let alert = UIAlertController(title: "Arbeitsstunden ist keine Zahl",
                                          message: "Bei der Angabe von Arbeitsstunden sind nur Zahlen erlaubt.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            controller.present(alert, animated: true)
            return false
        }
        
        return true
    }
    
    static func verifyOrPresent(appliedAmount: UITextField, _ controller: UIViewController) -> Bool {
        guard let appliedAmountText = appliedAmount.text, !appliedAmountText.isEmpty else {
            let alert = UIAlertController(title: "Ausgegebene Menge nicht angegeben",
                                          message: "Die ausgegebene Menge muss angegeben werden.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            controller.present(alert, animated: true)
            return false
        }
        
        guard Double(appliedAmountText) != nil else {
            let alert = UIAlertController(title: "Ausgegebene Menge ist keine Zahl",
                                          message: "Bei der Angabe von der ausgegebenen Menge sind nur Zahlen erlaubt.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            controller.present(alert, animated: true)
            return false
        }
        
        return true
    }
}
