//
//  AddDefoliationViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddDefoliationViewController: UIViewController {
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    
    var editIndex: Int?
    var source: DefoliationViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let editIndex = editIndex {
            date.date = source.defoliations[editIndex].date
            field.text = source.defoliations[editIndex].field
            user.text = source.defoliations[editIndex].user
            workingHours.text = String(source.defoliations[editIndex].workingHours)
        }
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let field = field.text, !field.isEmpty else {
            let alert = UIAlertController(title: "Feld nicht angegeben", message: "Das Feld darf nicht leer sein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let user = user.text, !user.isEmpty else {
            let alert = UIAlertController(title: "Benutzer nicht angegeben", message: "Der Benuzter darf nicht leer sein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let workingHoursText = workingHours.text, !workingHoursText.isEmpty else {
            let alert = UIAlertController(title: "Arbeitsstunden nicht angegeben", message: "Die Arbeitsstunden müssen angegeben sein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        guard let workingHours = Double(workingHoursText) else {
            let alert = UIAlertController(title: "Arbeitsstunden ist keine Zahl", message: "Bei der Angabe von Arbeitsstunden sind nur Zahlen zugelassen.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        if let editIndex = editIndex {
            source.defoliations[editIndex].date = date.date
            source.defoliations[editIndex].field = field
            source.defoliations[editIndex].user = user
            source.defoliations[editIndex].workingHours = workingHours
        } else {
            let defoliation = Defoliation(date: date.date,
                                          field: field,
                                          user: user,
                                          workingHours: workingHours)
            
            source.defoliations.append(defoliation)
        }
        
        source.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
