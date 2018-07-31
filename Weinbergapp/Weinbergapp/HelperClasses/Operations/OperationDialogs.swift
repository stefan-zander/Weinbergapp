//
//  OperationDialogs.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 27.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class OperationDialogs {
    
    static func presentLoadFailed(error: NSError, controller: UIViewController) {
        let alert = UIAlertController(title: "Fehler beim Laden der Daten",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        
        controller.present(alert, animated: true)
    }
    
    static func presentSaveFailed(error: NSError, controller: UIViewController) {
        let alert = UIAlertController(title: "Veränderungen konnten nicht gespeichert werden",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        controller.present(alert, animated: true)
    }
    
    static func presentDeletionFailed(error: NSError, controller: UIViewController) {
        let alert = UIAlertController(title: "Fehler beim Löschen",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        
        controller.present(alert, animated: true)
    }
}
