//
//  OperationFieldVerification2.swift
//  Weinbergapp
//
//  Created by VM on 27.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

public class OperationFieldVerification {
    
    public static func verify(field: UITextField, _ controller: UIViewController) -> Bool {
        guard let field = field.text, !field.isEmpty else {
            let alert = UIAlertController(title: "Feld nicht angegeben",
                                          message: "Ein Feld muss angegeben werden.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            
            controller.present(alert, animated: true)
            return false
        }
        
        return true
    }
    
    public static func verify(user: UITextField, _ controller: UIViewController) -> Bool {
        guard let user = user.text, !user.isEmpty else {
            let alert = UIAlertController(title: "Benutzer nicht angegeben",
                                          message: "Ein Benutzer muss angegeben werden.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            
            controller.present(alert, animated: true)
            return false
        }
        
        return true
    }
    
    public static func verify(workingHours: UITextField, _ controller: UIViewController) -> Bool {
        guard let workingHoursText = workingHours.text, !workingHoursText.isEmpty else {
            let alert = UIAlertController(title: "Arbeitsstunden nicht angegeben",
                                          message: "Die Arbeitsstunden müssen angegeben werden.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            
            controller.present(alert, animated: true)
            return false
        }
        
        guard Double(workingHoursText) != nil else {
            let alert = UIAlertController(title: "Arbeitsstunden ist keine Zahl",
                                          message: "Bei der Angabe von Arbeitsstunden sind nur Zahlen erlaubt.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            
            controller.present(alert, animated: true)
            return false
        }
        
        return true
    }
    
    public static func verify(appliedAmount: UITextField, _ controller: UIViewController) -> Bool {
        guard let appliedAmountText = appliedAmount.text, !appliedAmountText.isEmpty else {
            let alert = UIAlertController(title: "Ausgegebene Menge nicht angegeben",
                                          message: "Die ausgegebene Menge muss angegeben werden.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            
            controller.present(alert, animated: true)
            return false
        }
        
        guard Double(appliedAmountText) != nil else {
            let alert = UIAlertController(title: "Ausgegebene Menge ist keine Zahl",
                                          message: "Bei der Angabe von der ausgegebenen Menge sind nur Zahlen erlaubt.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            
            controller.present(alert, animated: true)
            return false
        }
        
        return true
    }
    
}
