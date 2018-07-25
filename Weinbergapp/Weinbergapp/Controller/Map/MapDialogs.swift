//
//  MapDialogs.swift
//  Weinbergapp
//
//  Created by VM on 24.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

public class MapDialogs {

    public static func showInsufficientPointsWarning(controller: UIViewController,
                                                     onCancel: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: "Nicht genügend Punkte eingezeichnet",
                                      message: "Um eine Fläche aufzuspannen werden mindestens drei Punkte " +
            "benötigt.",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Weitere Punkte einzeichnen", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Vorgang abbrechen", style: .cancel, handler: onCancel))

        controller.present(alert, animated: true)
    }
}
